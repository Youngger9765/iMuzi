class CommentsController < ApplicationController
  before_action :find_song,  only: :create
  def create
    @comment = current_user.comments.new(comment_params)
    @comment.song = @song
    if @comment.save
      flash[:success] = "更新成功!"
      redirect_to :back
    else
      flash[:alert] = "更新失敗!"
      redirect_to :back
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    redirect_to :back
  end

  private

  def comment_params
    params.require(:comment).permit(:comment)
  end

  def find_song
    @song = Song.find(params[:song])
  end

end
