class Admin::SongsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin_teacher

  def index
    sort_by = 'created_at DESC'
    @songs = Song.all.where(:use =>"study").order(sort_by)

    if params[:order]
      if params[:order] == "created_at_latest"
        sort_by = 'created_at DESC'
      elsif params[:order] == "created_at_oldest"
        sort_by = 'created_at ASC'

        
      end
      @songs = Song.all.where(:use =>"study").order(sort_by)
    end

    if params[:teacher]
      @songs = Song.all.where(:use =>"study").where(:teacher_choice => params[:teacher])
    end  

    if params[:reply] == "no"
      @songs = Song.all.where(:use =>"study").includes(:comments).where(:comments => {:status => nil})
    elsif params[:reply] == "yes"
      @songs = Song.all.where(:use =>"study").includes(:comments).where(:comments => {:status => 'professional'})
    end  

  end

  private

  def check_admin_teacher
    unless current_user.admin? || current_user.teacher?
        raise ActiveRecord::RecordNotFound
    end
  end 
end
