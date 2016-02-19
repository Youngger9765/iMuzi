class ProfilesController < ApplicationController

  before_action :find_user, :only=>[:edit, :update]
  before_action :find_profile, :only=>[:edit, :update]

  def edit
    
  end

  def update
    if params[:destroy_logo] == "1"
      @profile.logo = nil
    end

    if @profile.update(profile_params)

      flash[:notice] = "更新成功!"
      redirect_to edit_profile_path(@user,@user)
    else
      render "new"
    end
  end

  private

  def find_user
    @user = current_user
  end

  def find_profile
    @profile = current_user.profile
  end

  def profile_params
    params.require(:profile).permit(:username, :nickname, :about, :image,
                                    :birthday, :gender, :location, :age, 
                                    :job, :locale, :fb_link, :logo
                                )
  end

end
