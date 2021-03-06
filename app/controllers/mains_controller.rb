class MainsController < ApplicationController

  layout "landingpage", :only=>[:index, :register]

  def index
    if current_user && current_user.sign_in_count < 3
      redirect_to guide_mains_path

    elsif current_user
      redirect_to dojo_songs_path
    end
  end

  def register
  end

  def team_members
    
  end

  def guide
    
  end

  def lp_guide
    
  end

  def notification_click

    if current_user
      user = current_user
      user.notification_click_time = Time.now
      user.save!
    end

    respond_to do |format|
      format.html{ redirect_to :back}
      format.js
    end
  end

end
