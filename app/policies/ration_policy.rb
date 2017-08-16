class RationPolicy < ApplicationPolicy


  def index?
     @current_user.has_permission('Ration')
  end

  # GET /rations/1
  # GET /rations/1.json
  def show?
       @current_user.has_permission('Ration') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
  end

  # GET /rations/new
  def new?
        @current_user.has_permission('Ration') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # GET /rations/1/edit
  def edit?
      @current_user.has_permission('Ration') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # POST /rations
  # POST /rations.json
  def create?
    @current_user.has_permission('Ration') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # PATCH/PUT /rations/1
  # PATCH/PUT /rations/1.json
  def update?
    @current_user.has_permission('Ration') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # DELETE /rations/1
  # DELETE /rations/1.json
  def destroy?
    @current_user.has_permission('Ration') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  
end

