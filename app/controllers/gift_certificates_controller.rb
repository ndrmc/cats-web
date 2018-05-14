class GiftCertificatesController < ApplicationController
  before_action :set_gift_certificate, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_gift_certificate

  # GET /gift_certificates
  # GET /gift_certificates.json
  def index
    @gift_certificates = GiftCertificate.filter(params.slice(:organization_id, :status)).includes([:organization, :commodity, :mode_of_transport])
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

def gift_certificate_generate
        filter_map = {}
       if params[:gift_date ].present?
        dates = params[:gift_date].split(' - ').map { |d| Date.parse d }
        filter_map[:gift_date] = dates[0]..dates[1]
        @gift_certificate = GiftCertificate.where(filter_map).distinct
        @usd_currency_id = Currency.find_by(symbol: 'USD')
        @eth_currency_id = Currency.find_by(symbol: 'ETB')
        @toal_weight_in_MT = @gift_certificate.sum(:amount)
        @toal_estimated_price_in_usd = @gift_certificate.where(:currency_id => @usd_currency_id).sum(:estimated_price)
        @toal_estimated_price_in_birr = @gift_certificate.where(:currency_id => @eth_currency_id).sum(:estimated_price) 
        @total_estimated_tax = @gift_certificate.sum(:estimated_tax)
        
      
      else
         @gift_certificate = []
      end

    respond_to do |format|
            format.html
            format.pdf do
            pdf = GiftCertificatePdf.new(@gift_certificate,Organization,Commodity, Currency, dates[0],dates[1],@toal_weight_in_MT,@toal_estimated_price_in_usd,@toal_estimated_price_in_birr,@total_estimated_tax)
            send_data pdf.render, filename: "gift_certificate.pdf",
            type: "application/pdf",
            disposition: "inline"
            end
        end

  end
  
 def gift_certificate_report
 end
 

 def gift_certificate_finance_generate
        filter_map = {}
       if params[:gift_date ].present?
        dates = params[:gift_date].split(' - ').map { |d| Date.parse d }
        filter_map[:gift_date] = dates[0]..dates[1]
        @gift_certificate = GiftCertificate.where(filter_map).distinct
        @usd_currency_id = Currency.find_by(symbol: 'USD')
        @eth_currency_id = Currency.find_by(symbol: 'ETB')
        @toal_weight_in_MT = @gift_certificate.sum(:amount)
        @toal_estimated_price_in_usd = @gift_certificate.where(:currency_id => @usd_currency_id).sum(:estimated_price)
        @toal_estimated_price_in_birr = @gift_certificate.where(:currency_id => @eth_currency_id).sum(:estimated_price) 
        @total_estimated_tax = @gift_certificate.sum(:estimated_tax)
         @gift_certificate =  @gift_certificate.sort_by{ |h| CommodityCategory.find(Commodity.find(h.commodity_id).commodity_category_id).name}
        
      else
         @gift_certificate = []
      end

    respond_to do |format|
            format.html
            format.pdf do
            pdf = GiftCertificateFinancePdf.new(@gift_certificate,Organization,Commodity, Currency, dates[0],dates[1],@toal_weight_in_MT,@toal_estimated_price_in_usd,@toal_estimated_price_in_birr,@total_estimated_tax)
            send_data pdf.render, filename: "gift_certificate_finance.pdf",
            type: "application/pdf",
            disposition: "inline"
            end
        end

  end
 def gift_certificate_finance_report
 end
  private
  def authorize_gift_certificate
  #  authorize GiftCertificate
  end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_gift_certificate
      @gift_certificate = GiftCertificate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gift_certificate_params
      params.require(:gift_certificate).permit(:reference_no, :gift_date, :vessel, :organization_id, :eta, :program_id, :mode_of_transport_id,
      :port_name, :status, :customs_declaration_no,:purchase_year,:expiry_date,:fund_type_id,:account_no, :bill_of_loading, :amount,
      :estimated_price, :estimated_tax, :fund_source_id, :currency_id, :commodity_id)
    end
end
