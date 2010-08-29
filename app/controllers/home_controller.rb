class HomeController < ApplicationController
  layout 'home'
  before_filter :setup_context

  def dashboard
  end

  def messages
    @messages = Message.where(:to_id => @profile.id).paginate :page => params[:page], 
                                                           :per_page => 5,
                                                           :order => 'updated_at DESC'
  end

  def contacts
    @contacts = @profile.contacts
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
