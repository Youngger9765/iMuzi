class MainsController < ApplicationController

  layout "landingpage", :only=>[:index, :register]

  def index
    if current_user
      redirect_to dojo_songs_path
    end
  end

  def register
  end

  def team_members
    
  end

  def guide
    
  end

end
