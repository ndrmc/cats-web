class StockTakePolicy < ApplicationPolicy

    def index?
        @current_user.permission('StockTake', :guest)
    end

    def show?
        @current_user.permission('StockTake', :clerk)
    end

     def edit?
        @current_user.permission('StockTake', :clerk)
    end

    def new?
        @current_user.permission('StockTake', :clerk)
    end

    def create?
        @current_user.permission('StockTake', :clerk)
    end

    def post_stock_take?
        @current_user.permission('StockTake', :clerk)
    end
    

    def update?
        @current_user.permission('StockTake', :clerk)
    end

    def destroy?
        @current_user.permission('StockTake', :clerk)
    end
    

end
