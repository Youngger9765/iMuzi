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
      @song.link = song_params[:link][32,100]
    end

    if @song.save
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

      flash[:success] = "上傳成功!"
      redirect_to upload_user_path(@user)
    else
      if @song.introduction.blank?
        flash[:alert] = "上傳失敗! 請簡單敘述 作品簡介 或 明確的問題"
      else  
        flash[:alert] = "上傳失敗! 請檢查 '歌曲名稱' 及 'youtube連結' 為必填"
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
        @song.link = song_params[:link][32,100]
        @song.save!
      end

      if before_use != "study" && @song.use == "study"
        use_star
      end

      if before_use == "study" && @song.use != "study"
        restore_star
      end

      flash[:success] = "編輯成功!"
      redirect_to upload_user_path(@user)
    else
      render "new"
    end
  end

  def destroy
    if @song.use == "study" && !@song.teacher_comments?
      restore_star
      @song.destroy
      redirect_to upload_user_path(@user) 

    elsif @song.use == "study" && @song.teacher_comments?
      flash[:alert] = "此首歌曲已點評無法刪除，但可選擇隱藏或公開!"
      redirect_to upload_user_path(@user) 
    end

    
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
    @songs = Song.where(:use =>"battle")

    if current_user
      @comment = current_user.comments.build
    end
  end

  def dojo
    @songs = Song.where(:use =>"study")

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
                                  :teacher_choice, :use, :display)
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
end
