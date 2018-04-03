class GiftCertificatePolicy < ApplicationPolicy
     
     
  def index? 
    @current_user.permission('Gift Certificate', :guest)
  end

  # GET /gift_certificates/1
  # GET /gift_certificates/1.json
  def show?
    @current_user.permission('Gift Certificate', :guest)
  end

  # GET /gift_certificates/new
  def new?
    @current_user.permission('Gift Certificate', :clerk)
  end

  # GET /gift_certificates/1/edit
  def edit?
    @current_user.permission('Gift Certificate', :clerk)
  end

  # POST /gift_certificates
  # POST /gift_certificates.json
  def create?
    @current_user.permission('Gift Certificate', :clerk)
  end

  # PATCH/PUT /gift_certificates/1
  # PATCH/PUT /gift_certificates/1.json
  def update?
    @current_user.permission('Gift Certificate', :clerk)
  end

  # DELETE /gift_certificates/1
  # DELETE /gift_certificates/1.json
  def destroy?
    @current_user.permission('Gift Certificate', :clerk)
  end

  def gift_certificate_generate?
    @current_user.permission('Gift Certificate', :clerk)
  end
  
  def gift_certificate_report?
    @current_user.permission('Gift Certificate', :clerk)
  end
  

end

