class JournalPolicy < ApplicationPolicy
    
    def index?
      @current_user.permission('Journal', :guest)
    end
  
    # GET /journals/1
    # GET /journals/1.json
    def show?
      @current_user.permission('Journal', :guest)
    end
  
    # GET /journals/new
    def new?
      @current_user.permission('Journal', :clerk)
    end
  
    # GET /journals/1/edit
    def edit?
      @current_user.permission('Journal', :clerk)
    end
  
    # POST /journals
    # POST /journals.json
    def create?
      @current_user.permission('Journal', :clerk)
    end
  
    # PATCH/PUT /journals/1
    # PATCH/PUT /journals/1.json
    def update?
      @current_user.permission('Journal', :clerk)
    end
  
    # DELETE /journals/1
    # DELETE /journals/1.json
    def destroy?
      @current_user.permission('Journal', :clerk)
    end
  
  end
  