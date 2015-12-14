module UsersHelper

  def teacher_comment_alert
    if current_user
      last_login_record = Impression.where("user_id=? AND controller_name=? AND action_name=?", current_user.id, "users","show").last
      last_login_last_time = last_login_record.created_at
      teacher_comment_songs = current_user.songs.includes(:comments).where(:comments => {:status => "professional"})
      un_listen_songs = teacher_comment_songs.where("songs.created_at >= ?", last_login_last_time)
      un_listen_songs.count
    end
  end
end
