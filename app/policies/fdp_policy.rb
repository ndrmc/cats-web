class FdpPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Fdp', :guest)
    end
  
    # GET /fdps/1
    # GET /fdps/1.json
    def show?
      @current_user.permission('Fdp', :guest)
    end
  
    # GET /fdps/new
    def new?
      @current_user.permission('Fdp', :clerk)
    end
  
    # GET /fdps/1/edit
    def edit?
      @current_user.permission('Fdp', :clerk)
    end
  
    # POST /fdps
    # POST /fdps.json
    def create?
      @current_user.permission('Fdp', :clerk)
    end
  
    # PATCH/PUT /fdps/1
    # PATCH/PUT /fdps/1.json
    def update?
      @current_user.permission('Fdp', :clerk)
    end
  
    # DELETE /fdps/1
    # DELETE /fdps/1.json
    def destroy?
      @current_user.permission('Fdp', :admin)
    end
    
    def archive_fdp?
      @current_user.permission('Fdp', :clerk)
    end

    def unarchive_fdp?
       @current_user.permission('Fdp', :clerk)
    end
    
  end
  