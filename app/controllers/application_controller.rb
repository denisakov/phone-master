class ApplicationController < ActionController::Base
  add_flash_types :notice, :error
  # protect_from_forgery with: :exception
  # ApplicationNotAuthenticated = Class.new(Exception)

  def handleLogin()
    flash[:error] = "You are not authorized to access this page, please log in"
    redirect_to '/login'
  end

  # rescue_from ApplicationNotAuthenticated do
  #   respond_to do |format|
  #     # format.json { render json: { errors: [message: "401 Not Authorized"] }, status: 401 }
  #     format.html do
  #       flash[:error] = "You are not authorized to access this page, please log in"
  #       redirect_to '/login'
  #     end
  #     # format.any { head 401 }
  #   end
  # end

  def authentication_required!
    session[:current_user] || handleLogin()
    # raise(ApplicationNotAuthenticated)
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
  
  
end
