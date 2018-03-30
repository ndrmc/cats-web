class DispatchPolicy < ApplicationPolicy

    def index?
       permission = Permission.where(name: 'Dispatch', user_type: :guest).first
       @current_user.has_permission(permission.id)
    end

    def basic?
        permission = Permission.where(name: 'Dispatch', user_type: :guest).first
        @current_user.has_permission(permission.id)
    end

    def new?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def create?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def edit?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def update?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def dispatch_report?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def dispatch_report_generate?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end
    
    def check_stock?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def validate_quantity?
        permission = Permission.where(name: 'Dispatch', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end
end

