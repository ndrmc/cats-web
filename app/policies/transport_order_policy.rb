class TransportOrderPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('TransportOrder', :guest)
    end
  
  
    def show?
      @current_user.permission('TransportOrder', :guest)
    end
  
   
    def new?
      @current_user.permission('TransportOrder', :clerk)
    end
  
    
    def edit?
      @current_user.permission('TransportOrder', :clerk)
    end
  
    
    def create?
      @current_user.permission('TransportOrder', :clerk)
    end
  
    def update?
      @current_user.permission('TransportOrder', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('TransportOrder', :clerk)
    end

    def print?
        @current_user.permission('TransportOrder', :clerk)
    end

    def revert?
        @current_user.permission('TransportOrder', :clerk)
    end
  end
  
  