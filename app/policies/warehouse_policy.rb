class WarehousePolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Warehouse', :guest)
    end
  
  
    def show?
      @current_user.permission('Warehouse', :guest)
    end
  
   
    def new?
      @current_user.permission('Warehouse', :clerk)
    end
  
    
    def edit?
      @current_user.permission('Warehouse', :clerk)
    end
  
    
    def create?
      @current_user.permission('Warehouse', :clerk)
    end
  
    def update?
      @current_user.permission('Warehouse', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('Warehouse', :clerk)
    end
  end
  
  