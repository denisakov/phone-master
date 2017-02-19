class ApplicationController < ActionController::Base
  add_flash_types :notice, :error
  
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
