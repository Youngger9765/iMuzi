class Admin::UsersController < ApplicationController

  before_action :find_user, :only => [:update]

  def index
    @users = User.all
  end

  def update
    if @user.profile.nil? == false
      profile = @user.profile
      profile.role = params[:user][:role]
      profile.save!

    elsif @user.profile.nil? ==true
      profile = Profile.new(:user_id => @user.id, :role => "normal")
      profile.save!
    end
    
    redirect_to admin_users_path
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

end
