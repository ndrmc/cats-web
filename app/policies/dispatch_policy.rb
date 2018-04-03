class DispatchPolicy < ApplicationPolicy

    def index?
        @current_user.permission('Dispatch', :guest)
    end

    def basic?
        @current_user.permission('Dispatch', :guest)
    end

    def new?
        @current_user.permission('Dispatch', :clerk)
    end

    def create?
        @current_user.permission('Dispatch', :clerk)
    end

    def edit?
        @current_user.permission('Dispatch', :clerk)
    end

    def update?
        @current_user.permission('Dispatch', :clerk)
    end

    def dispatch_report?
        @current_user.permission('Dispatch', :clerk)
    end

    def dispatch_report_generate?
        @current_user.permission('Dispatch', :clerk)
    end
    
    def check_stock?
        @current_user.permission('Dispatch', :clerk)
    end

    def validate_quantity?
        @current_user.permission('Dispatch', :clerk)
    end

    def get_hub_warehouse?
        @current_user.has_permission('Dispatch') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

end

