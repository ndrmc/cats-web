class TransporterPaymentPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('TransporterPayment', :guest)
    end
  
  
    def show?
      @current_user.permission('TransporterPayment', :guest)
    end
  
   
    def new?
      @current_user.permission('TransporterPayment', :clerk)
    end
  
    
    def edit?
      @current_user.permission('TransporterPayment', :clerk)
    end
  
    
    def create?
      @current_user.permission('TransporterPayment', :clerk)
    end
  
    def update?
      @current_user.permission('TransporterPayment', :clerk)
    end
  
  
    def destroy?
      @current_user.permission('TransporterPayment', :clerk)
    end

    def update_status?
        @current_user.permission('TransporterPayment', :clerk)
    end
  end
  
  