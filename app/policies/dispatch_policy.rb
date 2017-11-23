class DispatchPolicy < ApplicationPolicy

   

    def index?
       @current_user.has_permission('Dispatch') 
    end

    def basic?
        @current_user.has_permission('Dispatch') 
    end

    def new?
       @current_user.has_permission('Dispatch') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def create?
         @current_user.has_permission('Dispatch') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def edit?
         @current_user.has_permission('Dispatch') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def update?
        @current_user.has_permission('Dispatch') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def dispatch_report
        @current_user.has_permission('Dispatch') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def dispatch_report_generate?
        @current_user.has_permission('Dispatch') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end
    
end

