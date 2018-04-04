class DonorPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Donor', :guest)
    end
  
    # GET /donors/1
    # GET /donors/1.json
    def show?
      @current_user.permission('Donor', :guest)
    end
  
    # GET /donors/new
    def new?
      @current_user.permission('Donor', :clerk)
    end
  
    # GET /donors/1/edit
    def edit?
      @current_user.permission('Donor', :clerk)
    end
  
    # POST /donors
    # POST /donors.json
    def create?
      @current_user.permission('Donor', :clerk)
    end
  
    # PATCH/PUT /donors/1
    # PATCH/PUT /donors/1.json
    def update?
      @current_user.permission('Donor', :clerk)
    end
  
    # DELETE /donors/1
    # DELETE /donors/1.json
    def destroy?
      @current_user.permission('Donor', :clerk)
    end
  
  end
  