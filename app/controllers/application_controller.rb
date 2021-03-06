class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  #protect_from_forgery with: :exception    #active_record_store
  protect_from_forgery with: :exception

  rescue_from CanCan::AccessDenied do |exception|  #cancancan
    redirect_to main_app.root_url, :alert => exception.message
  end
  
  def access_denied(exception)  #cancancan
    redirect_to root_path, :alert => exception.message
  end

  def user_for_paper_trail    #paper_trail gem
    user_signed_in? ? current_user.try(:id) : 'Unknown user'
  end
  


end
