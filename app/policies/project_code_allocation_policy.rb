class ProjectCodeAllocationPolicy < ApplicationPolicy
    

    def index?
        @current_user.has_permission('ProjectCodeAllocation')
    end
    
    def show?
        @current_user.has_permission('ProjectCodeAllocation') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
    end
    
    def new?
       @current_user.has_permission('ProjectCodeAllocation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def create?
         @current_user.has_permission('ProjectCodeAllocation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

    def edit?
        @current_user.has_permission('ProjectCodeAllocation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end
    
    def update?
         @current_user.has_permission('ProjectCodeAllocation') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
    end

end

