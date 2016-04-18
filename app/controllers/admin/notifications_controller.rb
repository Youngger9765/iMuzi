class Admin::NotificationsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin
  layout "admin"

  def index
    @notifications = Notification.all
  end

  def create
    
  end

  def show
    
  end

  def update
    
  end

  private

  def check_admin
    unless current_user.admin?
        raise ActiveRecord::RecordNotFound
    end
  end 


end
