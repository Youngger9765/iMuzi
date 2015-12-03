class SongsController < ApplicationController
  before_action :correct_user
  before_action :find_song,  only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only:[:new, :create, :edit, :update, :destroy]

  def new
    @song = @user.songs.build
  end

  def create
    @song = @user.songs.new(song_params)
    if @song.save
      flash[:success] = "上傳歌曲成功!"
      redirect_to @user
    else
      render "new"
    end
  end

  def show
    unless cookies["view-song-#{@song.id}"]
      @song.increment!(:views_count)
      cookies["view-song-#{@song.id}"] = true
    end
  end

  def edit
  end

  def update
    if @song.update(song_params)
      flash[:success] = "編輯歌曲成功!"
      redirect_to @user
    else
      render "new"
    end
  end

  def destroy
    @song.destroy
    redirect_to @user
  end

  private

  def correct_user
    @user = current_user
  end

  def find_song
    @song = @user.songs.find(params[:id])
  end

  def song_params
    params.require(:song).permit(:name, :singer, :introduction, :link, :picture)
  end
end
