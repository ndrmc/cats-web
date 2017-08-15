class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy, :generate_winners]

  # GET /bids
  # GET /bids.json
  def index
    @framework_tender = FrameworkTender.find params[:framework_tender_id]
    $framework_tender_id = params[:framework_tender_id]
    $framework_tender_no =  @framework_tender.year.to_s + '/' +  @framework_tender.half_year.to_s
    @bids = Bid.where(framework_tender_id: params[:framework_tender_id])
  end

  # GET /bids/1
  # GET /bids/1.json
  def show
  end

  # GET /bids/new
  def new
  @framework_tender_no =  $framework_tender_no
  @bid = Bid.new(framework_tender_id: $framework_tender_id)
  end

  # GET /bids/1/edit
  def edit
      @framework_tender_no =  $framework_tender_no
  end

  # POST /bids
  # POST /bids.json
  def create
    @bid = Bid.new(bid_params)
    @bid.status = Bid.statuses[:draft]
    respond_to do |format|
      if @bid.save
        format.html { redirect_to bids_url(:framework_tender_id => bid_params[:framework_tender_id] ), notice: 'Bid was successfully created.' }
        format.json { render :show, status: :created, location: @bid }
      else
        format.html { render :new }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bids/1
  # PATCH/PUT /bids/1.json
  def update
    respond_to do |format|
      if @bid.update(bid_params)
        format.html { redirect_to bids_url(:framework_tender_id => bid_params[:framework_tender_id] ), notice: 'Bid was successfully updated.' }
        format.json { render :show, status: :ok, location: @bid }
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bids/1
  # DELETE /bids/1.json
  def destroy
    @bid.destroy
    respond_to do |format|
      format.html { redirect_to bids_url, notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def update_status
     @bid = Bid.find params[:id]
     @bid.status =  Bid.get_index(params[:status])
   
        respond_to do |format|
            if @bid.save
                format.html { redirect_to bids_url(:framework_tender_id => @bid.framework_tender_id ), notice: 'Bid status was successfully updated.' }
            else
                format.html { 
                    flash[:error] = "Save failed! Please check your input and try again shortly."
                    redirect_to bids_url 
                }
            end
        end
  end

 def request_for_quotations

    set_bid
    @warehouse_allocation = WarehouseSelection.where(framework_tender_id: @bid.framework_tender_id)
    if @warehouse_allocation.count < 1
         flash[:error] = "Bid does not have warehouse allocation."
         redirect_to bids_url(:framework_tender_id => @bid.framework_tender_id) 
    else
    file_name = "Frmework Tender RFQ for " +  @warehouse_allocation.first.framework_tender&.year.to_s + '-' +  @warehouse_allocation.first.framework_tender&.half_year.to_s
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{file_name}.xlsx\""
      }
    end
    end
  end

 def upload_rfq

    file = params[:file]
    transporter_id = params[:transporter]
    bid_id =params[:bid_id]

    @bid = Bid.find(bid_id)
    file_not_supported=false
    case File.extname(file.original_filename)
    when '.xls' then spreadsheet = Roo::Excel.new(file.path, nil, :ignore)
    when '.xlsx' then spreadsheet = Roo::Excelx.new(file.path, nil, :ignore)
    else file_not_supported=true
    end

    
    if !file_not_supported


    number_of_skipped_rows = 0

    (13..spreadsheet.last_row).each do |i|
      row =  spreadsheet.row(i)
      bid_quotation_in_db = BidQuotation.where(bid_id: @bid.id, transporter_id: transporter_id).first
      if !bid_quotation_in_db.nil?
          bid_quotation_in_db = BidQuotationDetail.where(bid_quotation_id: bid_quotation_in_db.id, location_id: row[1], warehouse_id: row[0]).first
      end


      if bid_quotation_in_db
        if row[6].is_a?( Numeric) &&  row[6] >= 0 && !row[0].nil? && !row[1].nil?
          bid_quotation_in_db.tariff=row[6]
          bid_quotation_in_db.save
        else
          Rails.logger.info("No Warehouse allocation was found for the worda id: #{row[1]}. Skipping...")
        end

      else

         if row[6].is_a?( Numeric) &&  row[6] >= 0 && !row[0].nil? && !row[1].nil?
             bid_quotation = BidQuotation.create ({
             bid_id: @bid.id,
             bid_quotation_date: Date.today,
             transporter_id: transporter_id
               })

           bid_quotation.bid_quotation_details.create!(
                warehouse_id: row[0],
                location_id: row[1],
                tariff: row[6]
         )

         bid_quotation.save
        else
          number_of_skipped_rows += 1
        end

        end
      end

      respond_to do |format|
        if number_of_skipped_rows > 0
          flash[:error] = "#{number_of_skipped_rows} rows were skipped for having invalid values."
        end

        format.html { redirect_to bids_path(:framework_tender_id => @bid.framework_tender_id) , notice: "Excel imported successfully."  }
      end

    else
      respond_to do |format|
          format.html { redirect_to bids_path(:framework_tender_id => @bid.framework_tender_id) , alert: "The file is not supported."  }
      end
    end
  
  end

  def generate_winners
    @current_rank = 1
    @current_tariff = -1
    @current_location_id = -1
    @current_warehouse_id = -1
    @result = false


    i = 0
    record_count = BidQuotation.joins(:bid_quotation_details).where(:bid_id => params[:id]).count
    records = BidQuotation.joins(:bid_quotation_details).where(:bid_id => params[:id]).select(:id, 'bid_quotation_details.id AS bid_quotation_detail_id', :transporter_id, :bid_id, 'bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff').order('bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff')
    while i < record_count
      i = i + 1
      records.each do |bid_quotation_detail|
        bid_quo_det_obj = BidQuotationDetail.find(bid_quotation_detail.bid_quotation_detail_id)
        if (@current_tariff < 0 && @current_location_id < 0 && @current_warehouse_id < 0)

          bid_quo_det_obj.rank = @current_rank
          @current_tariff = bid_quo_det_obj.tariff
          @current_location_id = bid_quo_det_obj.location_id
          @current_warehouse_id = bid_quo_det_obj.warehouse_id
          puts "Case 1: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
        elsif (bid_quo_det_obj.tariff == @current_tariff && bid_quo_det_obj.location_id == @current_location_id && bid_quo_det_obj.warehouse_id == @current_warehouse_id)

          @current_tariff = bid_quo_det_obj.tariff
          @current_location_id = bid_quo_det_obj.location_id
          @current_warehouse_id = bid_quo_det_obj.warehouse_id
          bid_quo_det_obj.rank = @current_rank
          puts "Case 2: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
        elsif (bid_quo_det_obj.tariff > @current_tariff && bid_quo_det_obj.location_id == @current_location_id && bid_quo_det_obj.warehouse_id == @current_warehouse_id)

          @current_rank = @current_rank + 1
          @current_tariff = bid_quo_det_obj.tariff
          @current_location_id = bid_quo_det_obj.location_id
          @current_warehouse_id = bid_quo_det_obj.warehouse_id
          bid_quo_det_obj.rank = @current_rank
          puts "Case 3: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
        elsif (bid_quo_det_obj.location_id != @current_location_id || bid_quo_det_obj.warehouse_id != @current_warehouse_id)

          @current_rank = 1
          bid_quo_det_obj.rank = @current_rank
          @current_tariff = bid_quo_det_obj.tariff
          @current_location_id = bid_quo_det_obj.location_id
          @current_warehouse_id = bid_quo_det_obj.warehouse_id
          puts "Case 4: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
        else

          @current_rank = @current_rank + 1
          bid_quo_det_obj.rank = @current_rank
          @current_tariff = bid_quo_det_obj.tariff
          @current_location_id = bid_quo_det_obj.location_id
          @current_warehouse_id = bid_quo_det_obj.warehouse_id
          puts "Case 5: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
        end
        if (bid_quo_det_obj.save)
            @result = true
        end  
      end
      records = BidQuotation.joins(:bid_quotation_details).where(:bid_id => params[:id]).select(:id, 'bid_quotation_details.id AS bid_quotation_detail_id', :transporter_id, :bid_id, 'bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff').order('bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff')
    end


    # BidQuotation.joins(:bid_quotation_details).where(:bid_id => params[:id]).select(:id, 'bid_quotation_details.id AS bid_quotation_detail_id', :transporter_id, :bid_id, 'bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff').order('bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff')
    #   .find_each do |bid_quotation_detail|
    #     bid_quo_det_obj = BidQuotationDetail.find(bid_quotation_detail.bid_quotation_detail_id)
    #     if (@current_tariff < 0 && @current_location_id < 0 && @current_warehouse_id < 0)

    #       bid_quo_det_obj.rank = @current_rank
    #       @current_tariff = bid_quo_det_obj.tariff
    #       @current_location_id = bid_quo_det_obj.location_id
    #       @current_warehouse_id = bid_quo_det_obj.warehouse_id
    #       puts "Case 1: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}"
    #     elsif (bid_quo_det_obj.tariff == @current_tariff && bid_quo_det_obj.location_id == @current_location_id && bid_quo_det_obj.warehouse_id == @current_warehouse_id)

    #       bid_quo_det_obj.rank = @current_rank
    #       puts "Case 2: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}"
    #     elsif (bid_quo_det_obj.tariff > @current_tariff && bid_quo_det_obj.location_id == @current_location_id && bid_quo_det_obj.warehouse_id == @current_warehouse_id)

    #       @current_rank = @current_rank + 1
    #       bid_quo_det_obj.rank = @current_rank
    #       puts "Case 3: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}"
    #     elsif (bid_quo_det_obj.location_id != @current_location_id || bid_quo_det_obj.warehouse_id != @current_warehouse_id)

    #       @current_rank = 1
    #       bid_quo_det_obj.rank = @current_rank
    #       @current_tariff = bid_quo_det_obj.tariff
    #       @current_location_id = bid_quo_det_obj.location_id
    #       @current_warehouse_id = bid_quo_det_obj.warehouse_id
    #       puts "Case 4: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}"
    #     else

    #       @current_rank = @current_rank + 1
    #       bid_quo_det_obj.rank = @current_rank
    #       @current_tariff = bid_quo_det_obj.tariff
    #       @current_location_id = bid_quo_det_obj.location_id
    #       @current_warehouse_id = bid_quo_det_obj.warehouse_id
    #       puts "Case 5: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}"
    #     end
    #     if (bid_quo_det_obj.save)
    #         @result = true
    #     end  
    #   end
    # return @result
    respond_to do |format|
      if @result
        format.html { redirect_to bids_url(:framework_tender_id => @bid.framework_tender_id), notice: 'Bid winners were successfully generated.' }
        format.html { redirect_to bids_url, notice: 'Bid winners were successfully generated.' }
        format.json { render :show, status: :ok, location: @bid } 
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bid
      @bid = Bid.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bid_params
      params.require(:bid).permit(:framework_tender_id, :region_id, :bid_number, :bid_bond_amount, :start_date, :closing_date, :opening_date, :status, :remark)
    end
end
