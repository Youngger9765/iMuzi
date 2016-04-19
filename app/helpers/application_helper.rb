module ApplicationHelper

  def notifications 
    Notification.where(:user_id => nil).order("created_at DESC").limit(5)
  end
end
