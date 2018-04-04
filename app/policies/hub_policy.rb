class HubPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Hub', :guest)
    end
  
    # GET /hubs/1
    # GET /hubs/1.json
    def show?
      @current_user.permission('Hub', :guest)
    end
  
    # GET /hubs/new
    def new?
      @current_user.permission('Hub', :clerk)
    end
  
    # GET /hubs/1/edit
    def edit?
      @current_user.permission('Hub', :clerk)
    end
  
    # POST /hubs
    # POST /hubs.json
    def create?
      @current_user.permission('Hub', :clerk)
    end
  
    # PATCH/PUT /hubs/1
    # PATCH/PUT /hubs/1.json
    def update?
      @current_user.permission('Hub', :clerk)
    end
  
    # DELETE /hubs/1
    # DELETE /hubs/1.json
    def destroy?
      @current_user.permission('Hub', :clerk)
    end
  
  end
  