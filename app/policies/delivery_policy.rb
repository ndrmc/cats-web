class DeliveryPolicy < ApplicationPolicy
  
  def index?
    @current_user.permission('Delivery', :guest)
  end

  # GET /deliveries/1
  # GET /deliveries/1.json
  def show?
    @current_user.permission('Delivery', :guest)
  end

  # GET /deliveries/new
  def new?
    @current_user.permission('Delivery', :clerk)
  end

  # GET /deliveries/1/edit
  def edit?
    @current_user.permission('Delivery', :clerk)
  end

  # POST /deliveries
  # POST /deliveries.json
  def create?
    @current_user.permission('Delivery', :clerk)
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update?
    @current_user.permission('Delivery', :clerk)
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy?
    @current_user.permission('Delivery', :clerk)
  end

end
