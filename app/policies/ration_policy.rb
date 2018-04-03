class RationPolicy < ApplicationPolicy


  def index?
    @current_user.permission('Ration', :guest) 
  end

  # GET /rations/1
  # GET /rations/1.json
  def show?
    @current_user.permission('Ration', :guest)
  end

  # GET /rations/new
  def new?
    @current_user.permission('Ration', :clerk)
  end

  # GET /rations/1/edit
  def edit?
    @current_user.permission('Ration', :clerk)
  end

  # POST /rations
  # POST /rations.json
  def create?
    @current_user.permission('Ration', :clerk)
  end

  # PATCH/PUT /rations/1
  # PATCH/PUT /rations/1.json
  def update?
    @current_user.permission('Ration', :clerk)
  end

  # DELETE /rations/1
  # DELETE /rations/1.json
  def destroy?
    @current_user.permission('Ration', :clerk)
  end

  
end

