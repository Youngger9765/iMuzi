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

end
