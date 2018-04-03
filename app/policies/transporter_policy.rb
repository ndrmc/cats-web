class TransporterPolicy < ApplicationPolicy
     
 
  def index?
    @current_user.permission('Transporters', :guest)
  end

  def show?
    @current_user.permission('Transporters', :guest)
  end

  
  def new?
    @current_user.permission('Transporters', :clerk)
  end

 
  def edit?
    @current_user.permission('Transporters', :clerk)
  end

 
 
  def create?
    @current_user.permission('Transporters', :clerk)
  end

 
  def update?
    @current_user.permission('Transporters', :clerk)
  end

  
  
  def destroy?
    @current_user.permission('Transporters', :clerk)
  end
end
