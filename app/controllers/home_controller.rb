class HomeController < ApplicationController
  layout 'home'
  before_filter :setup_context

  def dashboard
  end

  def messages
    
  end


  def setup_context
    @user = User.find(session[:user])
    if @user.nil?
      redirect_to :controller => 'auth', :action => 'login'
    else
      @profile = @user.profile
      @contact_count = @profile.contact_count
      @message_count = @profile.message_count
    end
  end

end
