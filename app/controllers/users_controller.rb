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
    if @user.update(user_params)

      flash[:success] = "更新成功!"
      redirect_to edit_user_path(@user)
    else
      render "new"
    end
  end

  def destroy

  end

  def upload
    @songs = @user.songs.order("created_at DESC")
    delete_overtime_star
    add_monthly_star
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
    params.require(:user).permit(:name, :nickname, :email, :about, :picture,
                                 :address   
                                )
  end

  def correct_user
    @user = current_user
  end

  def delete_overtime_star
    @user = User.find(params[:id])
    @overtime_stars = @user.star_records.overtime_star

    if !@overtime_stars.blank?
      @overtime_stars.each do |s|
        s.status = "delete"
        s.save!
        user_star_record = @user.star_records.new( :free_star_count => @user.star_records.last.free_star_count-1,  
                                                      :money_star_count =>@user.star_records.last.money_star_count)
        user_star_record.action = "delete_free_star"
        user_star_record.save!
      end
      
      
    end
  end

  def add_monthly_star
    @user = User.find(params[:id])
    if @user.star_records.monthly_star.blank?
      user_star_record = @user.star_records.new(  :free_star_count => @user.star_records.last.free_star_count+1,  
                                                  :money_star_count =>@user.star_records.last.money_star_count)
      user_star_record.action = "add_monthly_star"
      user_star_record.save!
    end
  end

end
