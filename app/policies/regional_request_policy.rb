class RegionalRequestPolicy < ApplicationPolicy


  def index?
    @current_user.has_permission('Regional Requests')
  end


  def show?
     @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
  end

  
  def new?
    @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def edit?
    @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

 
  def create?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

 
  def update?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

 
  def destroy?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def add_fdp_to_request?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end
  
  def destroy_regional_request_item?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def update_regional_request_item?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def request_items?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def upload_requests?
      @current_user.has_permission('Regional Requests') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end 
  
end

