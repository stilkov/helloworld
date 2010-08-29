class HomeController < ApplicationController
  before_filter :require_auth

  def dashboard
    @user = session[:user]
  end

end
