class Admin::NotificationsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin
  before_action :find_notification,  only: [:show, :edit, :update, :destroy]
  layout "admin"

  def index
    @notifications = Notification.all.order("created_at DESC")
  end

  def new
    @notification = Notification.new
  end

  def create
    @notification = Notification.new(notification_params)
    @notification.save
    flash[:notice] = "推播成功!"    
    redirect_to admin_notifications_path

  end

  def destroy
    flash[:success] = "刪除推播成功!" 
    @notification.destroy
    redirect_to admin_notifications_path
  end


  private

  def check_admin
    unless current_user.admin?
        raise ActiveRecord::RecordNotFound
    end
  end

  def notification_params
    params.require(:notification).permit( :user_id, :title, :content)
  end

  def find_notification
    @notification = Notification.find(params[:id])
  end


end
