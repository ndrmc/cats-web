class ProjectCodeAllocationPolicy < ApplicationPolicy
    

    def index?
        @current_user.permission('ProjectCodeAllocation', :guest)
    end
    
    def show?
        @current_user.permission('ProjectCodeAllocation', :guest)
    end
    
    def new?
        @current_user.permission('ProjectCodeAllocation', :clerk)
    end

    def create?
        @current_user.permission('ProjectCodeAllocation', :clerk)
    end

    def edit?
        @current_user.permission('ProjectCodeAllocation', :clerk)
    end
    
    def update?
        @current_user.permission('ProjectCodeAllocation', :clerk)
    end

end

