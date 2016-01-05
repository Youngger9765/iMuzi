class Admin::CommentsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin_teacher

  def index
    @comments = Comment.all

    if current_user.teacher?
      @comments = current_user.comments.where(:role => "teacher", :status => "professional")
    end
    
  end

  private

  def check_admin_teacher
    unless current_user.admin? || current_user.teacher?
        raise ActiveRecord::RecordNotFound
    end
  end 

end
