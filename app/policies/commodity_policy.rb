class CommodityPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Commodity', :guest)
    end
  
    # GET /commodities/1
    # GET /commodities/1.json
    def show?
      @current_user.permission('Commodity', :guest)
    end
  
    # GET /commodities/new
    def new?
      @current_user.permission('Commodity', :clerk)
    end
  
    # GET /commodities/1/edit
    def edit?
      @current_user.permission('Commodity', :clerk)
    end
  
    # POST /commodities
    # POST /commodities.json
    def create?
      @current_user.permission('Commodity', :clerk)
    end
  
    # PATCH/PUT /commodities/1
    # PATCH/PUT /commodities/1.json
    def update?
      @current_user.permission('Commodity', :clerk)
    end
  
    # DELETE /commodities/1
    # DELETE /commodities/1.json
    def destroy?
      @current_user.permission('Commodity', :clerk)
    end
  
  end
  