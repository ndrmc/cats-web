class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :set_current_user

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  add_flash_types :success, :warning, :error, :info

  def set_current_user
    begin
      Current.user = current_user
      yield
    ensure
      # to address the thread variable leak issues in Puma/Thin webserver
      Current.user = nil
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end


 
