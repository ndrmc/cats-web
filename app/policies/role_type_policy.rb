class RoleTypePolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('RoleType', :guest)
    end
  
  
    def show?
      @current_user.permission('RoleType', :guest)
    end
  
   
    def new?
      @current_user.permission('RoleType', :clerk)
    end
  
    
    def edit?
      @current_user.permission('RoleType', :clerk)
    end
  
    
    def create?
      @current_user.permission('RoleType', :clerk)
    end
  
    def update?
      @current_user.permission('RoleType', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('RoleType', :clerk)
    end
  end
  
  