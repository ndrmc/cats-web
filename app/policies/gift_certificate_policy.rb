class GiftCertificatePolicy < ApplicationPolicy
     
     
  def index? 
     @current_user.permission('Gift Certificate', User.user_types[:guest])
  end

  # GET /gift_certificates/1
  # GET /gift_certificates/1.json
  def show?
    permission = Permission.where(name: 'Gift Certificate', user_type: :guest).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end

  # GET /gift_certificates/new
  def new?
    permission = Permission.where(name: 'Gift Certificate', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end

  # GET /gift_certificates/1/edit
  def edit?
    permission = Permission.where(name: 'Gift Certificate', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end

  # POST /gift_certificates
  # POST /gift_certificates.json
  def create?
    permission = Permission.where(name: 'Gift Certificate', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end

  # PATCH/PUT /gift_certificates/1
  # PATCH/PUT /gift_certificates/1.json
  def update?
    permission = Permission.where(name: 'Gift Certificate', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end

  # DELETE /gift_certificates/1
  # DELETE /gift_certificates/1.json
  def destroy?
    permission = Permission.where(name: 'Gift Certificate', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end

  def gift_certificate_generate?
    permission = Permission.where(name: 'Gift Certificate', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end
  
  def gift_certificate_report?
    permission = Permission.where(name: 'Gift Certificate', user_type: :clerk).first
     permission.nil? ? false : @current_user.has_permission(permission.id) 
  end
  

end

