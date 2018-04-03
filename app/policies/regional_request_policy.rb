class RegionalRequestPolicy < ApplicationPolicy


  def index?
    @current_user.permission('Regional Requests', User.user_types[:guest])
  end


  def show?
    permission = Permission.where(name: 'Regional Requests', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  
  def new?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def edit?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

 
  def create?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

 
  def update?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

 
  def destroy?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def add_fdp_to_request?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end
  
  def destroy_regional_request_item?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def update_regional_request_item?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def request_items?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  def upload_requests?
    permission = Permission.where(name: 'Regional Requests', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end 
  
end

