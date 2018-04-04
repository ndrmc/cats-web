class RolePolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Role', :guest)
    end
  
  
    def show?
      @current_user.permission('Role', :guest)
    end
  
   
    def new?
      @current_user.permission('Role', :clerk)
    end
  
    
    def edit?
      @current_user.permission('Role', :clerk)
    end
  
    
    def create?
      @current_user.permission('Role', :clerk)
    end
  
    def update?
      @current_user.permission('Role', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('Role', :clerk)
    end
  end
  
  