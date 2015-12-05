module SongsHelper
  #Like
  def song_like_class(song)
    if current_user && current_user.like_song?(song)
      "fa fa-heart"
    else
      "fa fa-heart-o"
    end    
  end

  def like_word(song)   
    if current_user && current_user.like_song?(song) 
      "取消讚"
    elsif current_user && !current_user.like_song?(song) 
      "按個讚吧"
    end 
      
  end

end
