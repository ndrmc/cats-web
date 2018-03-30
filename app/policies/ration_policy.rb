class RationPolicy < ApplicationPolicy


  def index?
     permission = Permission.where(name: 'Ration', user_type: :guest).first
     @current_user.has_permission(permission.id)
  end

  # GET /rations/1
  # GET /rations/1.json
  def show?
    permission = Permission.where(name: 'Ration', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  # GET /rations/new
  def new?
    permission = Permission.where(name: 'Ration', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # GET /rations/1/edit
  def edit?
    permission = Permission.where(name: 'Ration', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # POST /rations
  # POST /rations.json
  def create?
    permission = Permission.where(name: 'Ration', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # PATCH/PUT /rations/1
  # PATCH/PUT /rations/1.json
  def update?
    permission = Permission.where(name: 'Ration', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # DELETE /rations/1
  # DELETE /rations/1.json
  def destroy?
    permission = Permission.where(name: 'Ration', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  
end

