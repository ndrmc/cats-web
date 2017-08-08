class LocationPolicy < ApplicationPolicy
  
  def index?
     @current_user.has_permission('locations')
  end

 
  def show?
     @current_user.has_permission('locations') && @current_user.user_type_in([ 'admin','manager'])
  end


  def create?
    @current_user.has_permission('locations') && @current_user.user_type_in(['admin',  'manager'])
   
  end

  
  def edit?
    @current_user.has_permission('locations') && @current_user.user_type_in(['admin', 'manager'])
  end

  def update?
    @current_user.has_permission('locations') && @current_user.user_type_in([ 'admin', 'manager'])
  end

 
  def destroy?
    @current_user.has_permission('locations') && @current_user.user_type_in([ 'admin',  'manager'])
  end

  def children?
    @current_user.has_permission('locations') && @current_user.user_type_in([ 'admin',  'cleark',  'manager']) 
  end
end

