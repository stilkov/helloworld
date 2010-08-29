class AuthController < ApplicationController
  # Note: this implementation is a security nightmare 
  # and NOT intended for production use.

  def login
    @user = User.new
    @dest ||= home_path
  end

  def authenticate
    @user = User.find_by_login(params[:user][:login])
    if @user and @user.password == params[:user][:password]
      session[:user] = @user
      dest = params[:dest] || home_path
      redirect_to dest
    else
      flash[:notice] = "Wrong username/password combination"
      redirect_to :action => :login
    end
  end

  def logout
    session.delete(:user)
  end

  def register
    @user = User.new
  end

  def register_user
    @user = User.find_by_login(params[:user][:login])
    if @user.nil?
      @user = User.create(params[:user])
      session[:user] = @user
      dest = params[:dest] || home_path
      redirect_to dest
    else
      flash[:notice] = "Could not create user - user name already taken"
      redirect_to :action => :register
    end
  end

end
