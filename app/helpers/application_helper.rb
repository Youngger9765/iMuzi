module ApplicationHelper

  def notifications 
    Notification.all.order("created_at DESC").limit(5)
  end
end
