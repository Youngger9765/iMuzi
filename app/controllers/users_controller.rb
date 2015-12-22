class UsersController < ApplicationController
  
  layout "application"

  before_action :correct_user, only: [:edit, :update]
  before_action :authenticate_user!, except: [:index, :contact, :clause]
  before_action :find_user, only: [:show, :edit, :update, :upload]

  impressionist

  def index
    @users = User.all
  end

  def show
    @songs = @user.songs.order("created_at DESC")
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

  def upload
    @songs = @user.songs.order("created_at DESC")
  end

  def contact
  end

  def clause
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :nickname, :email, :about, :picture)
  end

  def correct_user
    @user = current_user
  end
end
