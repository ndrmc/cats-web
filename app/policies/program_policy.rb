class ProgramPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Program', :guest)
    end
  
  
    def show?
      @current_user.permission('Program', :guest)
    end
  
   
    def new?
      @current_user.permission('Program', :clerk)
    end
  
    
    def edit?
      @current_user.permission('Program', :clerk)
    end
  
    
    def create?
      @current_user.permission('Program', :clerk)
    end
  
    def update?
      @current_user.permission('Program', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('Program', :clerk)
    end
  end
  
  