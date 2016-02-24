module UsersHelper

  def teacher_comment_alert

    if current_user
      last_login_record = Impression.where("user_id=? AND controller_name=? AND action_name=?", current_user.id, "users","upload").last
      if last_login_record
        last_login_last_time = last_login_record.created_at
      else
        last_login_last_time = nil
      end
      teacher_comment_songs = current_user.songs.includes(:comments).where(:comments => {:status => "professional"})

      if teacher_comment_songs.size > 0
        un_listen_songs = teacher_comment_songs.where("comments.updated_at >= ?", last_login_last_time)
        un_listen_songs.count
      else
        0
      end  
    end
  end

  def mail_alert

    if current_user
      
      mails = Mailbox.all
      last_mail_record = mails.last
      
      if last_mail_record
        last_mail_record_time = last_mail_record.created_at
      end

      last_read_mail_record = Impression.where("user_id=? AND controller_name=? AND action_name=?", current_user.id, "users","mailbox").last
      
      if last_read_mail_record
        last_read_mail_record_time = last_read_mail_record.created_at
      end

      if last_mail_record_time && last_read_mail_record_time && (last_mail_record_time > last_read_mail_record_time)
        un_read_mails = mails.where("updated_at >= ?", last_read_mail_record_time)
        un_read_mails.count
      else
        0
      end  
    end
  end
end
