class SongsController < ApplicationController
  before_action :correct_user
  before_action :find_song,  only: [:show, :edit, :update, :destroy, :like]
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

  def index
    @songs = Song.all
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
      flash[:success] = "上傳成功!"
      redirect_to @user
    else
      flash[:alert] = "上傳失敗!"
      render "new"
    end
  end

  def show
    @song = Song.find(params[:id])
    @song_user = @song.user
    @comment = current_user.comments.build
    @comments = @song.comments
    unless cookies["view-song-#{@song.id}"]
      @song.increment!(:views_count)
      cookies["view-song-#{@song.id}"] = true
    end
  end

  def edit
  end

  def update
    if @song.update(song_params)
      if song_params[:link][0,32] == "https://www.youtube.com/watch?v="
        @song.link = song_params[:link][32,100]
        @song.save!
      end
      flash[:success] = "編輯成功!"
      redirect_to @user
    else
      render "new"
    end
  end

  def destroy
    @song.destroy
    redirect_to @user
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
      @like_song.delete

      respond_to do |format|
        format.html{ redirect_to :back}
        format.js
      end
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
    params.require(:song).permit(:name, :singer, :introduction, :link, :picture)
  end
end
