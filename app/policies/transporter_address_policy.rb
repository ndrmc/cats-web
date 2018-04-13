class TransporterAddressPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('TransporterAddress', :guest)
    end
  
  
    def show?
      @current_user.permission('TransporterAddress', :guest)
    end
  
   
    def new?
      @current_user.permission('TransporterAddress', :clerk)
    end
  
    
    def edit?
      @current_user.permission('TransporterAddress', :clerk)
    end
  
    
    def create?
      @current_user.permission('TransporterAddress', :clerk)
    end
  
    def update?
      @current_user.permission('TransporterAddress', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('TransporterAddress', :clerk)
    end
  end
  
  