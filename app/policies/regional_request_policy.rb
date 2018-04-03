class RegionalRequestPolicy < ApplicationPolicy


  def index?
    @current_user.permission('Regional Requests', :guest)
  end


  def show?
    @current_user.permission('Regional Requests', :guest)
  end

  
  def new?
    @current_user.permission('Regional Requests', :clerk)
  end

  def edit?
    @current_user.permission('Regional Requests', :clerk)
  end

 
  def create?
    @current_user.permission('Regional Requests', :clerk)
  end

 
  def update?
    @current_user.permission('Regional Requests', :clerk)
  end

 
  def destroy?
    @current_user.permission('Regional Requests', :clerk)
  end

  def add_fdp_to_request?
    @current_user.permission('Regional Requests', :clerk)
  end
  
  def destroy_regional_request_item?
    @current_user.permission('Regional Requests', :clerk)
  end

  def update_regional_request_item?
    @current_user.permission('Regional Requests', :clerk)
  end

  def request_items?
    @current_user.permission('Regional Requests', :clerk)
  end

  def upload_requests?
    @current_user.permission('Regional Requests', :clerk)
  end 
  
end

