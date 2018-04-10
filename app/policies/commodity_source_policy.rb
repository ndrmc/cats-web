class CommoditySourcePolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('CommoditySource', :guest)
    end
  
    # GET /commodity_sources/1
    # GET /commodity_sources/1.json
    def show?
      @current_user.permission('CommoditySource', :guest)
    end
  
    # GET /commodity_sources/new
    def new?
      @current_user.permission('CommoditySource', :clerk)
    end
  
    # GET /commodity_sources/1/edit
    def edit?
      @current_user.permission('CommoditySource', :clerk)
    end
  
    # POST /commodity_sources
    # POST /commodity_sources.json
    def create?
      @current_user.permission('CommoditySource', :clerk)
    end
  
    # PATCH/PUT /commodity_sources/1
    # PATCH/PUT /commodity_sources/1.json
    def update?
      @current_user.permission('CommoditySource', :clerk)
    end
  
    # DELETE /commodity_sources/1
    # DELETE /commodity_sources/1.json
    def destroy?
      @current_user.permission('CommoditySource', :clerk)
    end
  
  end
  