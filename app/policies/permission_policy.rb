class PermissionPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Permission', :guest)
    end
  
  
    def show?
      @current_user.permission('Permission', :guest)
    end
  
   
    def new?
      @current_user.permission('Permission', :clerk)
    end
  
    
    def edit?
      @current_user.permission('Permission', :clerk)
    end
  
    
    def create?
      @current_user.permission('Permission', :clerk)
    end
  
    def update?
      @current_user.permission('Permission', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('Permission', :clerk)
    end
  end
  
  