class BidsController < ApplicationController
  before_action :set_bid, only: [:show, :edit, :update, :destroy]

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
   
    set_bid
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
      warehouse_selection = WarehouseSelection.where(id: row[0]).first
      if warehouse_selection
        if row[5].is_a?( Numeric) && row[5] >= 0
          warehouse_selection.estimated_qty = row[5]
          warehouse_selection.save
        else
          number_of_skipped_rows += 1
        end
      else
        Rails.logger.info("No Warehouse allocation was found for the worda id: #{row[1]}. Skipping...")
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
