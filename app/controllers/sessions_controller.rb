class SessionsController < ApplicationController
    #   https://github.com/equivalent/scrapbook2/blob/master/archive/blogs/2016-09-simple-ralis-authentication-for-one-user.md
  def example
    "O HAI"
  end
  
  def new
    @site_user = SiteUser.new
  end

  def create
    sleep 2 # you can add sleep here  if you want to  slow down brute force attack
              # for normal application this is bad idea but for one
              # user login no-one care

    site_user_params = params.require(:site_user)

    @site_user = SiteUser.new
      .tap { |su| su.username = site_user_params[:username] }
      .tap { |su| su.password = site_user_params[:password] }

    if @site_user.login_valid?
      session[:current_user] = true
      flash[:notice] = 'Welcome back!'
      redirect_to '/contacts'
    else
      @site_user.password = nil
      flash[:error] = 'Sorry, wrong credentils'
      render 'new'
    end
  end
  
  def destroy
    reset_session
    redirect_to root_path
  end
end