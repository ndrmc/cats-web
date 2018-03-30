class ProjectCodeAllocationPolicy < ApplicationPolicy
    

    def index?
        permission = Permission.where(name: 'ProjectCodeAllocation', user_type: :guest).first
        @current_user.has_permission(permission.id)
    end
    
    def show?
        permission = Permission.where(name: 'ProjectCodeAllocation', user_type: :guest).first
        @current_user.has_permission(permission.id)
    end
    
    def new?
        permission = Permission.where(name: 'ProjectCodeAllocation', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def create?
        permission = Permission.where(name: 'ProjectCodeAllocation', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

    def edit?
        permission = Permission.where(name: 'ProjectCodeAllocation', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end
    
    def update?
        permission = Permission.where(name: 'ProjectCodeAllocation', user_type: :clerk).first
        @current_user.has_permission(permission.id)
    end

end

