module CommentsHelper

  def comment_class_by(role)
    if role == "teacher"
      "col-md-6 pull-left"
    else
      "col-md-6 col-md-offset-5"
    end  

  end
end
