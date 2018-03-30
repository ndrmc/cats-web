class StockTakePolicy < ApplicationPolicy

    def index?
         permission = Permission.where(name: 'StockTake', user_type: :guest).first
         @current_user.has_permission(permission.id)
    end

    def show?
        permission = Permission.where(name: 'StockTake', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

     def edit?
        permission = Permission.where(name: 'StockTake', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def new?
        permission = Permission.where(name: 'StockTake', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def create?
        permission = Permission.where(name: 'StockTake', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def post_stock_take?
        permission = Permission.where(name: 'StockTake', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end
    

    def update?
        permission = Permission.where(name: 'StockTake', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def destroy?
        permission = Permission.where(name: 'StockTake', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end
    

end
