class ReceiptPolicy < ApplicationPolicy

    def index?
        @current_user.has_permission('Receipts')
    end


    def new?
        @current_user.has_permission('Receipts') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end


    def create?
        @current_user.has_permission('Receipts') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def edit?
        @current_user.has_permission('Receipts') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def update?
        @current_user.has_permission('Receipts') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

end

