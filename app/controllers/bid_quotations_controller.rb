class BidQuotationsController < ApplicationController
  before_action :set_bid_quotation, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json
  # GET /bid_quotations
  # GET /bid_quotations.json
  def index
    if params[:transporter].present?
      @bid_quotations_details = BidQuotationDetail.includes(:bid_quotation).where(:'bid_quotations.transporter_id' => params[:transporter])
      return
    end

    if params[:transporter].present? && params[:bid].present?
      filter_map = {:'bid_quotations.transporter_id' => params[:transporter], :'bid_quotations.bid_id' => params[:bid]}
      @bid_quotations_details =  BidQuotationDetail.includes(:bid_quotation).where( filter_map )
    else
      @bid_quotations_details = []
    end
    
  end

  # GET /bid_quotations/1
  # GET /bid_quotations/1.json
  def show
  end

  # GET /bid_quotations/new
  def new
    @bid_quotation = BidQuotation.new
  end

  # GET /bid_quotations/1/edit
  def edit
  end

  # POST /bid_quotations
  # POST /bid_quotations.json
  def create
   
    bid_quotation_map = bid_quotation_params.except(:bid_quotation_details)
    @bid_quotation = BidQuotation.new(bid_quotation_map)
    @bid_quotation.created_by = current_user.id
    @bid_quotation.modified_by = current_user.id
    @bid_quotation_detail_params = bid_quotation_params[:bid_quotation_details]

    @existing_bq   =  BidQuotationDetail.includes(:bid_quotation).where(:'bid_quotations.transporter_id' => @bid_quotation.transporter_id, :'bid_quotations.bid_id' => @bid_quotation.bid_id, :location_id => @bid_quotation_detail_params[:location_id], :warehouse_id => @bid_quotation_detail_params[:warehouse_id]).count 

    respond_to do |format|
      if @existing_bq == 0
        if @bid_quotation.save
            
          BidQuotationDetail.new(bid_quotation: @bid_quotation, location_id: @bid_quotation_detail_params[:location_id],
          warehouse_id: @bid_quotation_detail_params[:warehouse_id], tariff: @bid_quotation_detail_params[:tariff_qty]).save

          format.html { redirect_to  request.referrer, notice: 'Bid Quotation was successfully created.' }
          format.json { render json: {}, status: 200 }

        else
          format.html { render :new }
          format.json { render json: @bid_quotation.errors, status: :unprocessable_entity }
        end
      else
        format.html { render :new }
        format.json { render json: @bid_quotation.errors, status: :unprocessable_entity }
      end
    end
  end
   
   
  def update_tariff
    @bid_quotation_detail = BidQuotationDetail.find(params[:id])
    @bid_quotation_detail.update_attributes(params[:bid_quotation_detail].permit(:tariff))
    respond_with @bid_quotation_detail
  end
  
  def delete_bid_quuotation_detail
    @bid_quotation_detail = BidQuotationDetail.find(params[:id])
    if !@bid_quotation_detail.blank?
       @bid_quotation_detail.destroy

       respond_to do |format|
              format.html { redirect_to  request.referrer, notice: 'Bid Quotation was successfully deleted.' }
            end
    else
       respond_to do |format|
        format.html { redirect_to  request.referrer, alert: 'Bid Quotation was not deleted.' }
        end
    end
  
 
  end
  
    


  # PATCH/PUT /bid_quotations/1
  # PATCH/PUT /bid_quotations/1.json
  def update
    respond_to do |format|
      if @bid_quotation.update(bid_quotation_params)
        format.html { redirect_to @bid_quotation, notice: 'Bid quotation was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid_quotation }
      else
        format.html { render :edit }
        format.json { render json: @bid_quotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bid_quotations/1
  # DELETE /bid_quotations/1.json
  def destroy
    @bid_quotation.destroy
    respond_to do |format|
      format.html { redirect_to bid_quotations_url, notice: 'Bid quotation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


    private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid_quotation
      @bid = BidQuotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_quotation_params
      params.require(:bid_quotation).permit(:bid_id, :transporter_id, :bid_quotation_date, :bid_quotation_details => [:location_id, :warehouse_id, :tariff])
    end
end
