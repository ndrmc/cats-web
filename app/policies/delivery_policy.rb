class DeliveryPolicy < ApplicationPolicy
  
  def index?
    @current_user.permission('Delivery', User.user_types[:guest])
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show?
    permission = Permission.where(name: 'Delivery', user_type: :guest).first
    @current_user.has_permission(permission.id) 
  end

  # GET /deliveries/new
  def new?
    permission = Permission.where(name: 'Delivery', user_type: :clerk).first
    @current_user.has_permission(permission.id) 
  end

  # GET /deliveries/1/edit
  def edit?
    permission = Permission.where(name: 'Delivery', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # POST /deliveries
  # POST /deliveries.json
  def create?
    permission = Permission.where(name: 'Delivery', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update?
    permission = Permission.where(name: 'Delivery', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy?
    permission = Permission.where(name: 'Delivery', user_type: :clerk).first
    @current_user.has_permission(permission.id)
  end

end
