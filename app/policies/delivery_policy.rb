class DeliveryPolicy < ApplicationPolicy
  
  
  
  def index?
    @current_user.has_permission('Delivery')
  end


  # GET /deliveries/1
  # GET /deliveries/1.json
  def show?
      @current_user.has_permission('Delivery') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
  end

  # GET /deliveries/new
  def new?
      @current_user.has_permission('Delivery') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # GET /deliveries/1/edit
  def edit?
      @current_user.has_permission('Delivery') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # POST /deliveries
  # POST /deliveries.json
  def create?
        @current_user.has_permission('Delivery') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update?
        @current_user.has_permission('Delivery') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy?
    @current_user.has_permission('Delivery') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

end
