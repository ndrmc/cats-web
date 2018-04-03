class RationPolicy < ApplicationPolicy


  def index?
    @current_user.permission('Ration', User.user_types[:guest])
  end

  # GET /rations/1
  # GET /rations/1.json
  def show?
    permission = Permission.where(name: 'Ration', user_type: :guest).first
    @current_user.has_permission(permission.id)
  end

  # GET /rations/new
  def new?
  @current_user.permission('Ration', User.user_types[:clerk])
  end

  # GET /rations/1/edit
  def edit?
    @current_user.permission('Ration', User.user_types[:clerk])
  end

  # POST /rations
  # POST /rations.json
  def create?
    @current_user.permission('Ration', User.user_types[:clerk])
  end

  # PATCH/PUT /rations/1
  # PATCH/PUT /rations/1.json
  def update?
    @current_user.permission('Ration', User.user_types[:clerk])
  end

  # DELETE /rations/1
  # DELETE /rations/1.json
  def destroy?
    @current_user.permission('Ration', User.user_types[:clerk])
  end

  
end

