class FdpContactPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('FdpContact', :guest)
    end
  
    # GET /fdp_contacts/1
    # GET /fdp_contacts/1.json
    def show?
      @current_user.permission('FdpContact', :guest)
    end
  
    # GET /fdp_contacts/new
    def new?
      @current_user.permission('FdpContact', :clerk)
    end
  
    # GET /fdp_contacts/1/edit
    def edit?
      @current_user.permission('FdpContact', :clerk)
    end
  
    # POST /fdp_contacts
    # POST /fdp_contacts.json
    def create?
      @current_user.permission('FdpContact', :clerk)
    end
  
    # PATCH/PUT /fdp_contacts/1
    # PATCH/PUT /fdp_contacts/1.json
    def update?
      @current_user.permission('FdpContact', :clerk)
    end
  
    # DELETE /fdp_contacts/1
    # DELETE /fdp_contacts/1.json
    def destroy?
      @current_user.permission('FdpContact', :clerk)
    end
  
  end
  