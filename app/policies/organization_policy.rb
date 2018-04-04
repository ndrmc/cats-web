class OrganizationPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Organization', :guest)
    end
  
  
    def show?
      @current_user.permission('Organization', :guest)
    end
  
   
    def new?
      @current_user.permission('Organization', :clerk)
    end
  
    
    def edit?
      @current_user.permission('Organization', :clerk)
    end
  
    
    def create?
      @current_user.permission('Organization', :clerk)
    end
  
    def update?
      @current_user.permission('Organization', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('Organization', :clerk)
    end
  end
  
  