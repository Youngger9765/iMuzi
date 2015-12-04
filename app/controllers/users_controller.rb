class UsersController < ApplicationController
  
  layout "application"

  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, except: [:index]

  def index

  end

  def show
    @user = User.find(params[:id])
    @songs = @user.songs
  end

  def new

  end

  def create

  end

  def edit

  end

  def update

  end

  def destroy

  end

  private

  def user_params
   params.require(:user).permit(:name, :nickname, :email, :about, :picture)
  end

  def correct_user
    @user = current_user
  end
end
