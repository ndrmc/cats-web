class StorePolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Store', :guest)
    end
  
  
    def show?
      @current_user.permission('Store', :guest)
    end
  
   
    def new?
      @current_user.permission('Store', :clerk)
    end
  
    
    def edit?
      @current_user.permission('Store', :clerk)
    end
  
    
    def create?
      @current_user.permission('Store', :clerk)
    end
  
    def update?
      @current_user.permission('Store', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('Store', :clerk)
    end
  end
  
  