class CommodityCategoryPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('CommodityCategory', :guest)
    end
  
    # GET /commodity_categories/1
    # GET /commodity_categories/1.json
    def show?
      @current_user.permission('CommodityCategory', :guest)
    end
  
    # GET /commodity_categories/new
    def new?
      @current_user.permission('CommodityCategory', :clerk)
    end
  
    # GET /commodity_categories/1/edit
    def edit?
      @current_user.permission('CommodityCategory', :clerk)
    end
  
    # POST /commodity_categories
    # POST /commodity_categories.json
    def create?
      @current_user.permission('CommodityCategory', :clerk)
    end
  
    # PATCH/PUT /commodity_categories/1
    # PATCH/PUT /commodity_categories/1.json
    def update?
      @current_user.permission('CommodityCategory', :clerk)
    end
  
    # DELETE /commodity_categories/1
    # DELETE /commodity_categories/1.json
    def destroy?
      @current_user.permission('CommodityCategory', :clerk)
    end
  
  end
  