class StockMovementPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('StockMovement', :guest)
    end
  
  
    def show?
      @current_user.permission('StockMovement', :guest)
    end
  
   
    def new?
      @current_user.permission('StockMovement', :clerk)
    end
  
    
    def edit?
      @current_user.permission('StockMovement', :clerk)
    end
  
    
    def create?
      @current_user.permission('StockMovement', :clerk)
    end
  
    def update?
      @current_user.permission('StockMovement', :clerk)
    end  
  
    def destroy?
      @current_user.permission('StockMovement', :clerk)
    end

    def check_stock?
        @current_user.permission('StockMovement', :clerk)
    end

    def close?
        @current_user.permission('StockMovement', :clerk)
    end

    def stock_movement_dispatch?
        @current_user.permission('StockMovement', :clerk)
    end

    def stock_movement_dispatch_edit?
        @current_user.permission('StockMovement', :clerk)
    end

    def get_dispatch?
        @current_user.permission('StockMovement', :clerk)
    end

    def delete_dispatch?
        @current_user.permission('StockMovement', :clerk)
    end

    def getCommodity?
        @current_user.permission('StockMovement', :clerk)
    end

    def createReceive?
        @current_user.permission('StockMovement', :clerk)
    end

    def stock_movement_edit?
        @current_user.permission('StockMovement', :clerk)
    end

    def stock_movement_destroy_receive?
        @current_user.permission('StockMovement', :clerk)
    end

    def get_total_dispatched_amount_for_project_code?
        @current_user.permission('StockMovement', :clerk)
    end

    def get_dispatched_amount_for_project_code?
        @current_user.permission('StockMovement', :clerk)
    end

    def get_received_amount_for_project_code?
        @current_user.permission('StockMovement', :clerk)
    end

    def validate_quantity?
        @current_user.permission('StockMovement', :clerk)
    end
  end
  
  