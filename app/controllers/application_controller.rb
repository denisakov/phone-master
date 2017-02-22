class ApplicationController < ActionController::Base
  add_flash_types :notice, :error
  
  ApplicationNotAuthenticated = Class.new(Exception)

  rescue_from ApplicationNotAuthenticated do
    respond_to do |format|
      # format.json { render json: { errors: [message: "401 Not Authorized"] }, status: 401 }
      format.html do
        flash[:error] = "You are not authorized to access this page, please log in"
        redirect_to '/sessions/new'
      end
      # format.any { head 401 }
    end
  end

  def authentication_required!
    session[:current_user] || raise(ApplicationNotAuthenticated)
  end
  
  # rescue_from ActionController::RoutingError do |exception|
  # logger.error 'Routing error occurred'
  # render plain: '404 Not found', status: 404 
  # redirect_to root_url
  # end
  
  # rescue_from ActionView::MissingTemplate do |exception|
  #   logger.error exception.message
  #   render plain: '404 Not found', status: 404
  #   redirect_to root_url
  # end
  
  protect_from_forgery with: :exception
end
