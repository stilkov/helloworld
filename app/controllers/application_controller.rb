class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  def require_auth
    if session[:user].nil?
      redirect_to :controller => 'auth', :action => 'login'
    end
  end
end
