class LocationPolicy < ApplicationPolicy
  
  def index?
    @current_user.permission('locations', :guest)
  end

 
  def show?
    @current_user.permission('locations', :manager)
  end


  def create?
    @current_user.permission('locations', :manager)
  end

  
  def edit?
    @current_user.permission('locations', :manager)
  end

  def update?
    @current_user.permission('locations', :manager)
  end

 
  def destroy?
    @current_user.permission('locations', :manager)
  end

  def children?
    @current_user.permission('locations', :clerk)
  end
end

