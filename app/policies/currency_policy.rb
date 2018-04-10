class CurrencyPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Currency', :guest)
    end
  
    # GET /currencies/1
    # GET /currencies/1.json
    def show?
      @current_user.permission('Currency', :guest)
    end
  
    # GET /currencies/new
    def new?
      @current_user.permission('Currency', :clerk)
    end
  
    # GET /currencies/1/edit
    def edit?
      @current_user.permission('Currency', :clerk)
    end
  
    # POST /currencies
    # POST /currencies.json
    def create?
      @current_user.permission('Currency', :clerk)
    end
  
    # PATCH/PUT /currencies/1
    # PATCH/PUT /currencies/1.json
    def update?
      @current_user.permission('Currency', :clerk)
    end
  
    # DELETE /currencies/1
    # DELETE /currencies/1.json
    def destroy?
      @current_user.permission('Currency', :clerk)
    end
  
  end
  