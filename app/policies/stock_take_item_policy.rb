class StockTakeItemPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('StockTakeItem', :guest)
    end
  
  
    def show?
      @current_user.permission('StockTakeItem', :guest)
    end
  
   
    def new?
      @current_user.permission('StockTakeItem', :clerk)
    end
  
    
    def edit?
      @current_user.permission('StockTakeItem', :clerk)
    end
  
    
    def create?
      @current_user.permission('StockTakeItem', :clerk)
    end
  
    def update?
      @current_user.permission('StockTakeItem', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('StockTakeItem', :clerk)
    end
end
  
  