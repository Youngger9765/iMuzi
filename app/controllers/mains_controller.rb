class MainsController < ApplicationController

  layout "landingpage"

  def index
    if current_user
      redirect_to dojo_songs_path
    end
  end

  def register
  end

end
