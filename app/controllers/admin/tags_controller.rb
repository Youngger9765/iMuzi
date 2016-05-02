class Admin::TagsController < ApplicationController

  before_action :authenticate_user!
  before_action :check_admin_teacher
  before_action :find_tag, :only=>[:edit, :update, :destroy]

  def index
    @tags = ActsAsTaggableOn::Tag.all
  end

  def update
    
  end

  def destroy
    @tag.taggings.destroy
    @tag.destroy
    redirect_to admin_tags_path
  end

  private

  def check_admin_teacher
    unless current_user.admin? || current_user.teacher?
        raise ActiveRecord::RecordNotFound
    end
  end

  def find_tag
    @tag = ActsAsTaggableOn::Tag.find(params[:id])    
  end  

end
