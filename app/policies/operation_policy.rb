class OperationPolicy < ApplicationPolicy
  
  def index?
     @current_user.has_permission('Operation')
  end


  def show?
     @current_user.has_permission('Operation') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
  end

 
  def new?
     @current_user.has_permission('Operation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  
  def edit?
     @current_user.has_permission('Operation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  
  def create?
    @current_user.has_permission('Operation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  def update?
    @current_user.has_permission('Operation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end


  def destroy?
    @current_user.has_permission('Operation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end
end

