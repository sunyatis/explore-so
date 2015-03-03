class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to :back, :alert => "Access denied."
    end
  end
  
  def user_params
    params.require(:user).permit(:school_id)
  end

end
