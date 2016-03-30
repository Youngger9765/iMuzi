class SongsController < ApplicationController
  before_action :correct_user
  before_action :find_song,  only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

  impressionist

  def index
    @songs = Song.all

    if current_user
      @comment = current_user.comments.build
    end
  end

  def new
    @song = @user.songs.build
  end

  def create
    @song = @user.songs.new(song_params)

    if song_params[:link][0,32] == "https://www.youtube.com/watch?v="
      @song.link = song_params[:link][32,11]
      @song.source = "youtube"
      @song.save

    elsif song_params[:link][0,17] == "https://youtu.be/"
      @song.link = song_params[:link][17,11]
      @song.source = "youtube"
      @song.save

    elsif song_params[:link][0,27] == "http://17sing.tw/song/sid="
      @song.link = song_params[:link][27,15]
      @song.source = "17sing"
      @song.save

    elsif song_params[:link][0,22] == "http://17sing.tw/song/"
      @song.link = song_params[:link][22,15]
      @song.source = "17sing"
      @song.save

    else
      flash[:alert] = "上傳失敗! 請檢查 '作品連結' 格式"
    end

    if !@song.id.nil?

      if @song.use == "study" 
        user_star_record = @current_user.star_records.new(  :free_star_count => @user.star_records.last.free_star_count,  
                                                            :money_star_count =>@user.star_records.last.money_star_count,
                                                            :song_id => @song.id
                                                          )
        if user_star_record.free_star_count > 0
          user_star_record.free_star_count -= 1 
          user_star_record.action = "use_free_star"
        elsif user_star_record.free_star_count ==0 && user_star_record.money_star_count > 0
          user_star_record.money_star_count -= 1 
          user_star_record.action = "use_money_star"
        else user_star_record.money_star_count == 0 && user_star_record.free_star_count ==0
          redirect_to :back
        end

        user_star_record.save!
      end

      if @song.user.id.to_i % 2 == 0
        @song.teacher_choice = "偉誌老師"
        @song.save
      else
        @song.teacher_choice = "小九老師"
        @song.save
      end

      SongMailer.notify_song(@user,@song).deliver_now!

      flash[:notice] = "上傳成功!"
      redirect_to upload_user_path(@user)
    else
      if params[:song][:name].blank?
        flash[:alert] = "上傳失敗! 請檢查 '歌曲名稱' 為必填"
      elsif params[:song][:introduction].blank?
        flash[:alert] = "上傳失敗! 請簡單敘述 作品簡介 或 明確的問題"
      end

      render "new"
    end
  end

  def show
    @song = Song.find(params[:id])
    @song_user = @song.user

    if current_user
      @comment = current_user.comments.build
    end

    @comments = @song.comments.where(:status => "normal")
    @pro_comments = @song.comments.where(:status => "professional")
    unless cookies["view-song-#{@song.id}"]
      @song.increment!(:views_count)
      cookies["view-song-#{@song.id}"] = true
    end

  end

  def edit
  end

  def update
    before_use = @song.use

    if @song.use == "study" && @song.teacher_comments?
      flash[:alert] = "此作品已受點評，無法編輯!"
      redirect_to upload_user_path(@user)

    elsif @song.update(song_params)

      if song_params[:link][0,32] == "https://www.youtube.com/watch?v="
        @song.link = song_params[:link][32,11]
        @song.source = "youtube"
        @song.save

      elsif song_params[:link][0,17] == "https://youtu.be/"
        @song.link = song_params[:link][17,11]
        @song.source = "youtube"
        @song.save

      elsif song_params[:link][0,22] == "http://17sing.tw/song/"
        @song.link = song_params[:link][22,20]
        @song.source = "17sing"
        @song.save

      else
        flash[:alert] = "上傳失敗! 請檢查 '作品連結' 格式"
      end

      if before_use != "study" && @song.use == "study"
        use_star
      end

      if before_use == "study" && @song.use != "study"
        restore_star
      end

      if params[:admin] == "1"
        flash[:notice] = "編輯成功!"
        redirect_to admin_songs_path

      else
        flash[:notice] = "編輯成功!"
        redirect_to upload_user_path(@user)
      end
      
    else
      render "new"
    end
  end

  def destroy
    if @song.use == "study" && !@song.teacher_comments?
      restore_star
      @song.destroy

    elsif @song.use == "study" && @song.teacher_comments?
      if current_user.admin?
        restore_star
        @song.destroy
      else  
        flash[:alert] = "此首歌曲已點評無法刪除，但可選擇隱藏或公開!"
      end  

    else
      @song.destroy
    end

    redirect_to upload_user_path(@user) 
  end

  def like
    if current_user && !current_user.likings.find_by(:song_id => params[:id])
      @like = current_user.likings.new
      @like.song_id = params[:id]
      @like.save

      respond_to do |format|
        format.html{ redirect_to :back}
        format.js
      end

    else
      @like_song = current_user.likings.find_by(:song_id => params[:id])
      @like_song.destroy

      respond_to do |format|
        format.html{ redirect_to :back}
        format.js
      end
    end
  end

  def youtube_teach
    respond_to do |format|
      format.html{ redirect_to :back}
      format.js
    end
  end

  def battle
    @songs = Song.where(:use =>"battle").order("created_at DESC")

    if params[:order]
      if params[:order] == 'popular'
        sort_by = 'likings_count'
      elsif params[:order] == 'updated'
        sort_by = 'updated_at'
      else
        sort_by = 'created_at'
      end
      
      sort_by = sort_by + " DESC"
      @songs = Song.where(:use =>"study").order(sort_by)
    end

    if current_user
      @comment = current_user.comments.build
    end
  end

  def dojo
    @songs = Song.where(:use =>"study").order("created_at DESC")

    if params[:order]
      if params[:order] == 'popular'
        sort_by = 'likings_count'
      elsif params[:order] == 'updated'
        sort_by = 'updated_at'
      else
        sort_by = 'created_at'
      end
      
      sort_by = sort_by + " DESC"
      @songs = Song.where(:use =>"study").order(sort_by)
    end

    if current_user
      @comment = current_user.comments.build
    end
  end

  private

  def correct_user
    @user = current_user
  end

  def find_song
    @song = Song.find(params[:id])
  end

  def song_params
    params.require(:song).permit( :name, :singer, :introduction, :link, :picture,
                                  :teacher_choice, :use, :display, :study_target)
  end

  def restore_star
    user_star_record = @current_user.star_records.new(:free_star_count => @user.star_records.last.free_star_count,  
                                                        :money_star_count =>@user.star_records.last.money_star_count,
                                                        :song_id => @song.id
                                                        )
      if @song.star_records.last.action == "use_free_star"
        user_star_record.free_star_count += 1 
        user_star_record.action = "restore_free_star"
      elsif @song.star_records.last.action == "use_money_star"
        user_star_record.money_star_count += 1 
        user_star_record.action = "restore_money_star"
      end
    user_star_record.save!
  end

  def use_star
    user_star_record = @current_user.star_records.new(  :free_star_count => @user.star_records.last.free_star_count,  
                                                            :money_star_count =>@user.star_records.last.money_star_count,
                                                            :song_id => @song.id
                                                          )
    if user_star_record.free_star_count > 0
      user_star_record.free_star_count -= 1 
      user_star_record.action = "use_free_star"
    elsif user_star_record.free_star_count ==0 && user_star_record.money_star_count > 0
      user_star_record.money_star_count -= 1 
      user_star_record.action = "use_money_star"
    else user_star_record.money_star_count == 0 && user_star_record.free_star_count ==0
      redirect_to :back
    end
    user_star_record.save!
  end

  def check_user_go_to_guide?
    last_dojo_time = Impression.where(:user_id => current_user).where(:action_name => "dojo").last.created_at

    if current_user && current_user.sign_in_count < 5
      redirect_to guide_mains_path
    end
  end
end
