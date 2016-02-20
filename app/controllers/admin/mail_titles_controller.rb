class Admin::MailTitlesController < ApplicationController

  before_action :authenticate_user!
  before_action :find_title, :only =>[:edit, :update, :destroy]
  layout "admin"

  def index
    @mailtitles = MailTitle.all
  end

  def new
    @title = MailTitle.new
  end

  def create
    @title = MailTitle.create(title_params)

    redirect_to admin_mail_titles_path

  end

  def edit

  end

  def update
    
  end

  def destroy
    
  end

  private

  def title_params
    params.require(:mail_title).permit( :name)
  end

  def find_title
    @title = MailTitle.find(params[:id])
  end
end
