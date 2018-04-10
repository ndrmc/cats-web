class UnitOfMeasurePolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('UnitOfMeasure', :guest)
    end
  
  
    def show?
      @current_user.permission('UnitOfMeasure', :guest)
    end
  
   
    def new?
      @current_user.permission('UnitOfMeasure', :clerk)
    end
  
    
    def edit?
      @current_user.permission('UnitOfMeasure', :clerk)
    end
  
    
    def create?
      @current_user.permission('UnitOfMeasure', :clerk)
    end
  
    def update?
      @current_user.permission('UnitOfMeasure', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('UnitOfMeasure', :clerk)
    end
  end
  
  