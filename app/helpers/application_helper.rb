module ApplicationHelper

  def notifications 
    #notifications = Notification.where(:user_id => nil).order("created_at DESC").limit(5)

    if current_user
      user = current_user
      notifications = Notification.where("user_id IS NULL || user_id =?", user.id).order("created_at DESC").limit(5)
    else
      notifications = Notification.where(:user_id => nil).order("created_at DESC").limit(5)
    end
  end
end
