class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :set_current_user

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user! 
  before_action :set_locale
 
  def set_locale
    I18n.locale = (current_user&&current_user.language)  ? current_user.language : params[:locale] 
  end  
  
  def default_url_options
   { locale: I18n.locale }
  end

  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

private

def user_not_authorized
  flash[:warning] = "You are not authorized to perform this action."
  redirect_to(request.referrer || root_path)
end


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


 
