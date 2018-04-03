class ReceiptPolicy < ApplicationPolicy

    def index?
        @current_user.permission('Receipts', :guest)
    end

    def new?
        @current_user.permission('Receipts', :clerk)
    end

    def create?
        @current_user.permission('Receipts', :clerk)
    end

    def edit?
        @current_user.permission('Receipts', :clerk)
    end

    def update?
        @current_user.permission('Receipts', :clerk)
    end

end

