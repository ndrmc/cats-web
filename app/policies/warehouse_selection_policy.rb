class WarehouseSelectionPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('WarehouseSelection', :guest)
    end
  
  
    def show?
      @current_user.permission('WarehouseSelection', :guest)
    end
  
   
    def new?
      @current_user.permission('WarehouseSelection', :clerk)
    end
  
    
    def edit?
      @current_user.permission('WarehouseSelection', :clerk)
    end
  
    
    def create?
      @current_user.permission('WarehouseSelection', :clerk)
    end
  
    def update?
      @current_user.permission('WarehouseSelection', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('WarehouseSelection', :clerk)
    end

    def get_by_region?
        @current_user.permission('WarehouseSelection', :clerk)
    end
  end
  
  