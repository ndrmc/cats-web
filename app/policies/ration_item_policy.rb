class RationItemPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('RationItem', :guest)
    end
  
  
    def show?
      @current_user.permission('RationItem', :guest)
    end
  
   
    def new?
      @current_user.permission('RationItem', :clerk)
    end
  
    
    def edit?
      @current_user.permission('RationItem', :clerk)
    end
  
    
    def create?
      @current_user.permission('RationItem', :clerk)
    end
  
    def update?
      @current_user.permission('RationItem', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('RationItem', :clerk)
    end
  end
  
  