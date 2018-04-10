class TransportRequisitionPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('TransportRequisition', :guest)
    end
  
  
    def show?
      @current_user.permission('TransportRequisition', :guest)
    end
  
   
    def new?
      @current_user.permission('TransportRequisition', :clerk)
    end
  
    
    def edit?
      @current_user.permission('TransportRequisition', :clerk)
    end
  
    
    def create?
      @current_user.permission('TransportRequisition', :clerk)
    end
  
    def update?
      @current_user.permission('TransportRequisition', :clerk)
    end
    
    def destroy?
      @current_user.permission('TransportRequisition', :clerk)
    end

    def print?
        @current_user.permission('TransportRequisition', :clerk)
    end

    def get_fdps_list?
        @current_user.permission('TransportRequisition', :clerk)
    end

    def create_to_for_exceptions?
        @current_user.permission('TransportRequisition', :clerk)
    end
  end
  
  