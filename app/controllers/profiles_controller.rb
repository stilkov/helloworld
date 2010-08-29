class ProfilesController < ApplicationController

  respond_to :html, :json

  def show_public
    @profile = Profile.find(params[:id])
    respond_with @profile
  end

  def show
    @profile = Profile.find(params[:id])
    @contacts = @profile.contacts
    respond_with @profile
  end

end
