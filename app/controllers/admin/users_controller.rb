class Admin::UsersController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin

  before_action :find_user, :only => [:update, :destroy]

  def index
    @users = User.all
  end

  def update
    if @user.profile.nil? == false
      profile = @user.profile
      profile.role = params[:user][:role]
      profile.save!

    elsif @user.profile.nil? == true
      profile = Profile.new(:user_id => @user.id, :role => params[:user][:role])
      profile.save!
    end
    
    redirect_to admin_users_path
  end

  def destroy
     @user.destroy
     flash[:notice] = "刪除成功!"
     redirect_to admin_users_path
  end

  def mailbox
    @mails = Mailbox.all
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  private

  def check_admin
    unless current_user.admin?
        raise ActiveRecord::RecordNotFound
    end
  end 

end
