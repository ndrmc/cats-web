class GiftCertificatesController < ApplicationController
  before_action :set_gift_certificate, only: [:show, :edit, :update, :destroy]

  # GET /gift_certificates
  # GET /gift_certificates.json
  def index
    @gift_certificates = GiftCertificate.filter(params.slice(:donor_id, :status))
  end

  # GET /gift_certificates/1
  # GET /gift_certificates/1.json
  def show
  end

  # GET /gift_certificates/new
  def new
    @gift_certificate = GiftCertificate.new
  end

  # GET /gift_certificates/1/edit
  def edit
   
  end

  # POST /gift_certificates
  # POST /gift_certificates.json
  def create
    @gift_certificate = GiftCertificate.new(gift_certificate_params)

    respond_to do |format|
      if @gift_certificate.save
        format.html { redirect_to gift_certificates_path, notice: 'Gift certificate was successfully created.' }
        format.json { render :index, status: :created, location: @gift_certificate }
      else
        format.html { render :new }
        format.json { render json: @gift_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /gift_certificates/1
  # PATCH/PUT /gift_certificates/1.json
  def update
    respond_to do |format|
      if @gift_certificate.update(gift_certificate_params)
        format.html { redirect_to gift_certificates_path, notice: 'Gift certificate was successfully updated.' }
        format.json { render :edit, status: :ok, location: @gift_certificate }
      else
        format.html { render :edit }
        format.json { render json: @gift_certificate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /gift_certificates/1
  # DELETE /gift_certificates/1.json
  def destroy
    @gift_certificate.destroy
    respond_to do |format|
      format.html { redirect_to gift_certificates_url, notice: 'Gift certificate was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gift_certificate
      @gift_certificate = GiftCertificate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_certificate_params
      params.require(:gift_certificate).permit(:reference_no, :gift_date, :vessel, :donor_id, :eta, :program_id, :mode_of_transport_id, 
      :port_name, :status, :customs_declaration_no,:purchase_year,:expiry_date,:fund_type_id,:account_no, :bill_of_loading, :amount,
      :estimated_price, :estimated_tax, :fund_source_id, :currency_id, :commodity_id)
    end
end
  
    
   