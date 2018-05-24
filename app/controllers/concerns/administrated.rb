module Administrated
  extend ActiveSupport::Concern

  included do
    before_action :authorize_admin, except: [:user_preference, :updateUserPreference] 
  end

  def authorize_admin
    authorize(:admin, :admin?)
  end
end