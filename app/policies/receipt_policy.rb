class ReceiptPolicy < ApplicationPolicy

    def index?
       @current_user.permission('Receipts', User.user_types[:guest])
    end


    def new?
        permission = Permission.where(name: 'Receipts', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end


    def create?
        permission = Permission.where(name: 'Receipts', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def edit?
        permission = Permission.where(name: 'Receipts', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def update?
        permission = Permission.where(name: 'Receipts', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

end

