class OperationPolicy < ApplicationPolicy
  
  def index?
    @current_user.permission('Operation', :guest)
  end


  def show?
    @current_user.permission('Operation', :guest)
  end

 
  def new?
    @current_user.permission('Operation', :clerk)
  end

  
  def edit?
    @current_user.permission('Operation', :clerk)
  end

  
  def create?
    @current_user.permission('Operation', :clerk)
  end

  def update?
    @current_user.permission('Operation', :clerk)
  end


  def destroy?
    @current_user.permission('Operation', :clerk)
  end
end

