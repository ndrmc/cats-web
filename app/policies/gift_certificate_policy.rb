class GiftCertificatePolicy < ApplicationPolicy
     
     
  def index?
    @current_user.has_permission('Gift Certificate') 
  end

  # GET /gift_certificates/1
  # GET /gift_certificates/1.json
  def show?
       @current_user.has_permission('Gift Certificate') && @current_user.user_type_in(['guest', 'admin', 'cleark', 'manager'])
  end

  # GET /gift_certificates/new
  def new?
     @current_user.has_permission('Gift Certificate') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # GET /gift_certificates/1/edit
  def edit?
     @current_user.has_permission('Gift Certificate') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # POST /gift_certificates
  # POST /gift_certificates.json
  def create?
     @current_user.has_permission('Gift Certificate') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # PATCH/PUT /gift_certificates/1
  # PATCH/PUT /gift_certificates/1.json
  def update?
     @current_user.has_permission('Gift Certificate') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

  # DELETE /gift_certificates/1
  # DELETE /gift_certificates/1.json
  def destroy?
     @current_user.has_permission('Gift Certificate') && @current_user.user_type_in(['admin', 'cleark', 'manager'])
  end

end

