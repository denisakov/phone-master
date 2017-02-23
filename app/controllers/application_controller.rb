class ApplicationController < ActionController::Base
  add_flash_types :notice, :error
  protect_from_forgery with: :exception
  ApplicationNotAuthenticated = Class.new(Exception)

  # def handleLogin()
  #   flash[:error] = "You are not authorized to access this page, please log in"
  #   redirect_to '/login'
  # end

  rescue_from ApplicationNotAuthenticated do
    respond_to do |format|
      format.json { render json: { errors: [message: "401 Not Authorized"] }, status: 401 }
      format.html do
        flash[:error] = "You are not authorized to access this page, please log in"
        redirect_to login_path
      end
      format.any { head 401 }
    end
  end

  def authentication_required!
    # session[:current_user] || raise(ApplicationNotAuthenticated)
    # handleLogin()
    return
  end
  
end
