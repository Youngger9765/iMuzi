class CommentsController < ApplicationController
  before_action :find_song,  only: :create

  def create
    @comment = current_user.comments.new(comment_params)

    if params[:role]
      @comment.status = "professional"
      @comment.role = params[:role]
    else
      @comment.status = "normal"
    end

    if comment_params[:link][0,32] == "https://www.youtube.com/watch?v="
      @comment.link = comment_params[:link][32,11]
    elsif comment_params[:link][0,17] == "https://youtu.be/"
      @comment.link = comment_params[:link][17,11]
    else
      @comment.link = nil
    end

    @comment.song = @song
    if @comment.save
      flash[:notice] = "更新成功!"
      redirect_to :back
    else
      flash[:alert] = "文字，Youtube連結，照片 請擇一! 或檢查 Youtube 連結格式"
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  def update
    @comment = Comment.find(params[:id])

    if params[:destroy_logo] == "1"
      @comment.logo = nil
    end

    if @comment.update(comment_params)
      if comment_params[:link][0,32] == "https://www.youtube.com/watch?v="
        @comment.link = comment_params[:link][32,11]
      elsif comment_params[:link][0,17] == "https://youtu.be/"
        @comment.link = comment_params[:link][17,11]
      else
        @comment.link = nil
      end
      @comment.save!

      flash[:notice] = "更新成功!"
      redirect_to song_path(@comment.song)
    else
      render "new"
    end
  end

  def edit
    @comment = Comment.find(params[:id])
    @song = @comment.song
  end

  private

  def comment_params
    params.require(:comment).permit(:comment, :role, :link, :logo, :display)
  end

  def find_song
    @song = Song.find(params[:song])
  end

end
