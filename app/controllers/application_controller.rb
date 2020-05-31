class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include CurrentFavorite
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_favorite

  def after_database_authentication
    set_user_favorite
  end

  def authenticate_active_admin_user!
    authenticate_user!
    unless current_user.admin?
      flash[:alert] = "Unauthorized Access!"
      redirect_to root_path
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username])
  end


end

