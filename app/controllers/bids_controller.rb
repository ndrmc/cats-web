class BidsController < ApplicationController

  before_action :set_bid, only: [:show, :edit, :update, :destroy, :transporter_quotes, :generate_winners]
  include BidsHelper

  # GET /bids
  # GET /bids.json
  def index
    @framework_tender = FrameworkTender.find params[:framework_tender_id]
    $framework_tender_id = params[:framework_tender_id]
    $framework_tender_no =  @framework_tender.year.to_s + '/' +  @framework_tender.half_year.to_s
    @bids = Bid.where(framework_tender_id: params[:framework_tender_id])
    @ft_name = @framework_tender&.year.to_s + '/' + @framework_tender&.half_year.to_s
    @total_destinations = WarehouseSelection.where(:framework_tender_id => params[:id]).count
    @total_amount = WarehouseSelection.where(:framework_tender_id => params[:id]).sum(:estimated_qty)
    @user = User.find_by_id(@framework_tender&.certified_by)
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
        format.html { redirect_to framework_tender_path(@bid.framework_tender_id), notice: 'Bid was successfully created.' }
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
        format.html { redirect_to framework_tender_path(@bid.framework_tender_id), notice: 'Bid was successfully updated.' }
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
      format.html { redirect_to framework_tender_path(@bid.framework_tender_id), notice: 'Bid was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def update_status
     @bid = Bid.find params[:id]
     @bid.status =  Bid.get_index(params[:status])
   
        respond_to do |format|
            if @bid.save
                format.html { redirect_to framework_tender_path(@bid.framework_tender_id), notice: 'Bid status was successfully updated.' }
            else
                format.html { 
                    flash[:error] = "Save failed! Please check your input and try again shortly."
                    redirect_to framework_tender_path(@bid.framework_tender_id) 
                }
            end
        end
  end

 def request_for_quotations

    set_bid
    @warehouse_allocation = []
    WarehouseSelection.where(framework_tender_id: @bid.framework_tender_id)
      .find_each do |ws|
        region_id = Location.find(ws.location_id).parent.parent_node_id
        if region_id == @bid.region_id
          @warehouse_allocation << ws
        end
      end
    if @warehouse_allocation.count < 1
         flash[:error] = "Bid does not have warehouse allocation."
         redirect_to framework_tender_path(@bid.framework_tender_id) 
    else
    file_name = "Frmework Tender RFQ for " +  @warehouse_allocation.first.framework_tender&.year.to_s + '-' +  @warehouse_allocation.first.framework_tender&.half_year.to_s + '-' + Location.find(@bid.region_id)&.name + '-' + @bid.bid_number
    respond_to do |format|
      format.xlsx {
        response.headers['Content-Disposition'] = "attachment; filename=\"#{file_name}.xlsx\""
      }
    end
    end
  end

 def upload_rfq
    # Last row index in RFQ excel template
    excel_last_row = 17
    # Tariff column index number in the last row of the RFQ excel template
    tariff_column_index = 5
    # WarehouseSelection ID column index in the last row of the RFQ excel template
    ws_column_index = 0

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
    bid_quotation_for_transporter = BidQuotation.where(bid_id: @bid.id, transporter_id: transporter_id).first
    if bid_quotation_for_transporter.nil?
      bid_quotation = BidQuotation.create ({
             bid_id: @bid.id,
             bid_quotation_date: Date.today,
             transporter_id: transporter_id
               })
    end


    (excel_last_row..spreadsheet.last_row).each do |i|
      row =  spreadsheet.row(i)
      warehouse_selection = WarehouseSelection.find(row[ws_column_index])
      if !bid_quotation_for_transporter.nil?
          bid_quotation_in_db = BidQuotationDetail.where(bid_quotation_id: bid_quotation_for_transporter.id, location_id: warehouse_selection.location_id, warehouse_id: warehouse_selection.warehouse_id).first
      end
         
      
      if bid_quotation_in_db
        if row[tariff_column_index].is_a?( Numeric) &&  row[tariff_column_index] >= 0 && !warehouse_selection.nil?
          bid_quotation_in_db.tariff=row[tariff_column_index]
          bid_quotation_in_db.save
        

        end

      else

         if row[tariff_column_index].is_a?( Numeric) &&  row[tariff_column_index] >= 0 && !warehouse_selection.nil?  
                      
                 if !bid_quotation.nil?
                    bid_quotation.bid_quotation_details.create!(
                    warehouse_id: warehouse_selection.warehouse_id,
                    location_id: warehouse_selection.location_id,
                    tariff: row[tariff_column_index])

                    bid_quotation.save
                elsif !bid_quotation_for_transporter.nil?
                    bid_quotation_for_transporter.bid_quotation_details.create!(
                    warehouse_id: warehouse_selection.warehouse_id,
                    location_id: warehouse_selection.location_id,
                    tariff: row[tariff_column_index])

                    bid_quotation_for_transporter.save
           end

        else
          number_of_skipped_rows += 1
        end

        end
      end


      respond_to do |format|
        if number_of_skipped_rows > 0
          flash[:error] = "#{number_of_skipped_rows} rows were skipped for having invalid values."
        end

        format.html {  redirect_to request.referrer, notice: "Excel imported successfully."  }

      end

    else
      respond_to do |format|
          format.html {  redirect_to request.referrer, alert: "The file is not supported."  }
      end
    end
  
  end

  def generate_winners
    @result = generate_bid_winners(params[:id])

    respond_to do |format|
      if @result
        format.html { redirect_to framework_tender_path(@bid.framework_tender_id), notice: 'Bid winners were successfully generated.' }
        format.json { render :show, status: :ok, location: @bid } 
      else
        format.html { render :edit }
        format.json { render json: @bid.errors, status: :unprocessable_entity }
      end
    end
  end


    def transporter_quotes

      @transporters = BidQuotation.joins(:bid_quotation_details).references(:bid_quotation_details).select(
      'bid_quotations.bid_id','bid_quotations.transporter_id,count(bid_quotation_details.location_id) as destination_count').group(
      'bid_quotations.transporter_id,bid_quotations.bid_id').order('destination_count desc').where("bid_quotations.bid_id = ?", @bid.id )
      @framework_tender = FrameworkTender.find(@bid.framework_tender_id)
    end
    

    def remove_bid_quotation
      set_bid
      transporter_id = params[:transporter_id]
      @bid_quotation = BidQuotation.where(bid_id: @bid.id, transporter_id: transporter_id).first
      if @bid_quotation
        @bid_quotation.destroy
      end
      respond_to do |format|
        format.html { redirect_to request.referrer}
        format.json { head :no_content }
      end
      
    end

  def view_bid_winners
    @bid = Bid.find params[:id]
    if (!params[:hub].blank? && !params[:warehouse].blank?)
      puts 'hub and warehouse selected'
      @bid_winners = BidQuotationDetail.joins(:bid_quotation, :location, warehouse: :hub).where('bid_quotations.bid_id' => params[:id], 'hubs.id' => params[:hub], :warehouse_id => params[:warehouse]).select(:id, :transporter_id, :bid_id, :location_id, :warehouse_id, :tariff, :rank, :parent_node_id, 'hubs.id AS hub_id').order(:location_id, :warehouse_id, :tariff)
    elsif (!params[:hub].blank?)
      puts 'hub selected'
      @bid_winners = BidQuotationDetail.joins(:bid_quotation, :location, warehouse: :hub).where('bid_quotations.bid_id' => params[:id], 'hubs.id' => params[:hub]).select(:id, :transporter_id, :bid_id, :location_id, :warehouse_id, :tariff, :rank, :parent_node_id, 'hubs.id AS hub_id').order(:location_id, :warehouse_id, :tariff)
    else
      puts 'nothing selected'
      @bid_winners = BidQuotationDetail.joins(:bid_quotation, :location, warehouse: :hub).where('bid_quotations.bid_id' => params[:id]).select(:id, :transporter_id, :bid_id, :location_id, :warehouse_id, :tariff, :rank, :parent_node_id, 'hubs.id AS hub_id').order(:location_id, :warehouse_id, :tariff)
    end  
    
  end

  def contracts
    @bid = Bid.find(params[:id])
    @transporters = BidQuotationDetail.joins(bid_quotation: {bid: :framework_tender}).where(:rank => 1, :'bid_quotations.bid_id' => params[:id]).group(:'bid_quotations.transporter_id').count(:location_id).to_a
  end

  def download_contract
    @bid = Bid.find(params[:id])
    @contract_no = 'LTCD/' + @bid.id.to_s + '/' + Time.current.year.to_s + '/' + Transporter.find(params[:transporter_id]).name.to_s
    @transporter = Transporter.find(params[:transporter_id])
    @transporter_info = 'The Transporter Company/ Agency ' + @transporter.name + ' here in after refered as "Carrier" '
    @count = 0
    @transporter.transporter_addresses.each do |transporter_address|
      @count = @count + 1
      @transporter_info += ' Address ' + @count.to_s + ':- SubCity: ' + transporter_address.subcity.to_s + ' Kebele: ' + transporter_address.kebele.to_s + ' HouseNo: ' + transporter_address.house_no.to_s   
    end
    @printed_by = current_user.name
    @region_name = 'Region: ' + Location.find(@bid.region_id).name
    @bid_number = 'Bid Number: ' + @bid.bid_number.to_s
    @bid_start_date = 'Bid Date: ' + @bid.start_date.to_s
    @won_locations = [['No.', 'Hub', 'Warehouse(Origin)', 'Zone', 'Woreda(Destination)', 'Tariff/Qtl(in birr)']]
    @no = 1
    @destinations = BidQuotationDetail.joins(bid_quotation: {bid: :framework_tender}).where(:rank => 1, :'bid_quotations.bid_id' => params[:id], :'bid_quotations.transporter_id' => params[:transporter_id]).select(:id, :warehouse_id, :location_id, :tariff)
      .find_each do |destination|
        @woreda = Location.find(destination.location_id)
        @warehouse = Warehouse.find(destination.warehouse_id)
        @row = [@no, @warehouse.hub.name, @warehouse.name, @woreda.parent.name, @woreda.name, destination.tariff]
        @won_locations << @row
        @no = @no + 1
      end
    @contract = Contract.where(:transporter_id => @transporter.id, :bid_id => @bid.id)&.first
    if (@contract.present?)
      @contract.last_printed_at = Time.current
      @contract.printed_copies = @contract.printed_copies + 1
      @contract.save
    else
      @contract = Contract.new(bid_id: @bid.id, transporter_id: @transporter.id, contract_no: @contract_no, signed: false, last_printed_at: Time.current, printed_copies: 1)
      @contract.save
    end
    
    respond_to do |format|
      format.docx { headers["Content-Disposition"] = "attachment; filename=\" " + @transporter.name + "-" + @bid.bid_number.to_s + ".docx\"" }
    end
  end

  def sign_contract
    @contract = Contract.where(:transporter_id => params[:transporter_id], :bid_id => params[:id])&.first
    @post_print_update = BidQuotationDetail.joins(:bid_quotation).where(:'bid_quotations.bid_id' => params[:id]).where("bid_quotations.updated_at > ? OR bid_quotation_details.updated_at > ?", @contract.last_printed_at, @contract.last_printed_at).first
    respond_to do |format|
      if (@post_print_update.present?)
        format.html {
          flash[:error] = "Contract has not been signed as related data was updated after the contract\'s last print date."
          redirect_to request.referrer 
        }
      elsif (@contract.present?)
        @contract.signed = true
        if (@contract.save)        
          format.html { redirect_to '/en/bids/contracts/'+params[:id], notice: 'Contract has been successfully signed.' }
          format.json { render :show, status: :ok, contract: @contract } 
        else
          format.html { render :contracts }
          format.json { render json: @contract.errors, status: :unprocessable_entity }
        end        
      else
        format.html { render :contracts }
        format.json { render json: @contract.errors, status: :unprocessable_entity }
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
      params.require(:bid).permit(:framework_tender_id, :region_id, :bid_number, :bid_bond_amount, :start_date, :closing_date, :opening_date, :status, :remark, :hub, :warehouse, :zone, :woreda)
    end
end
