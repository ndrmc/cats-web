class DepartmentPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Department', :guest)
    end
  
    # GET /departments/1
    # GET /departments/1.json
    def show?
      @current_user.permission('Department', :guest)
    end
  
    # GET /departments/new
    def new?
      @current_user.permission('Department', :clerk)
    end
  
    # GET /departments/1/edit
    def edit?
      @current_user.permission('Department', :clerk)
    end
  
    # POST /departments
    # POST /departments.json
    def create?
      @current_user.permission('Department', :clerk)
    end
  
    # PATCH/PUT /departments/1
    # PATCH/PUT /departments/1.json
    def update?
      @current_user.permission('Department', :clerk)
    end
  
    # DELETE /departments/1
    # DELETE /departments/1.json
    def destroy?
      @current_user.permission('Department', :clerk)
    end
  
  end
  