class WarehouseAllocationPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('WarehouseAllocation', :guest)
    end
  
  
    def show?
      @current_user.permission('WarehouseAllocation', :guest)
    end
  
   
    def new?
      @current_user.permission('WarehouseAllocation', :clerk)
    end
  
    
    def edit?
      @current_user.permission('WarehouseAllocation', :clerk)
    end
  
    
    def create?
      @current_user.permission('WarehouseAllocation', :clerk)
    end
  
    def update?
      @current_user.permission('WarehouseAllocation', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('WarehouseAllocation', :clerk)
    end

    def generate?
        @current_user.permission('WarehouseAllocation', :clerk)
    end

    def reset_allocation?
        @current_user.permission('WarehouseAllocation', :clerk)
    end

    def reverse_allocation?
       @current_user.permission('WarehouseAllocation', :clerk)
    end
    
    def close_allocation?
        @current_user.permission('WarehouseAllocation', :clerk)
    end

    def change_wai?
        @current_user.permission('WarehouseAllocation', :clerk)
    end

    def change_wa_woreda?
        @current_user.permission('WarehouseAllocation', :clerk)
    end

    def warehouse_allocation_fdp_view?
        @current_user.permission('WarehouseAllocation', :guest)
    end

    def warehouse_allocation_zonal_view?
        @current_user.permission('WarehouseAllocation', :guest)
    end

    def is_tr_created_for_this_warehouse_allocatoin?
       @current_user.permission('WarehouseAllocation', :guest)
    end

  end
  
  