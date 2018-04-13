class ContributionPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Contribution', :guest)
    end
  
    # GET /contributions/1
    # GET /contributions/1.json
    def show?
      @current_user.permission('Contribution', :guest)
    end
  
    # GET /contributions/new
    def new?
      @current_user.permission('Contribution', :clerk)
    end
  
    # GET /contributions/1/edit
    def edit?
      @current_user.permission('Contribution', :clerk)
    end
  
    # POST /contributions
    # POST /contributions.json
    def create?
      @current_user.permission('Contribution', :clerk)
    end
  
    # PATCH/PUT /contributions/1
    # PATCH/PUT /contributions/1.json
    def update?
      @current_user.permission('Contribution', :clerk)
    end
  
    # DELETE /contributions/1
    # DELETE /contributions/1.json
    def destroy?
      @current_user.permission('Contribution', :clerk)
    end
  
  end
  