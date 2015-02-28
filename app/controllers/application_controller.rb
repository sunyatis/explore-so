class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
      redirect_to main_app.root_url, :alert => exception.message
    end
  
  
  def authenticate_active_admin_user!
     authenticate_user!
     unless current_user.role?(:admin)
        flash[:alert] = 'You are not authorized to access this resource!'
        redirect_to root_path
     end
  end
  
  
  
end
