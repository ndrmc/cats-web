class BidQuotationsController < ApplicationController
  
  def index
    
  end
  
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
   
   
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid_quotation
      @bid = BidQuotation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_quotation_params
      params.require(:bid_quotation).permit(:bid_id, :transporter_id, :bid_quotation_date, :bid_quotation_details => [:location_id, :warehouse_id, :tariff_qty])
    end

end
