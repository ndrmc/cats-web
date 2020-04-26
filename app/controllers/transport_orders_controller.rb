require 'humanize'

class TransportOrdersController < ApplicationController
  before_action :set_transport_order, only: [:show, :edit, :update, :destroy, :move, :save_to_dates]
 include ReferenceHelper
  # GET /transport_orders
  # GET /transport_orders.json
  def index
    @result = ""
    @where_clause = "transport_orders.id IS NOT NULL"
    if params[:order_no].present?
      @where_clause += " and order_no = '#{params[:order_no]}'"
      @result += "Order No: #{params[:order_no]} | "
    end
    if params[:operation].present?
      @where_clause += " and operation_id = #{params[:operation]}" 
      @result += "Operation: #{Operation.find(params[:operation])&.name} | "
    end
    if params[:region].present?
      @where_clause += " and location_id = #{params[:region]}" 
      @result += "Region: #{Location.find(params[:region])&.name} | "
    end
    if params[:requisition_no].present?
      @where_clause += " and transport_order_items.requisition_no = '#{params[:requisition_no]}'"
      @result += "Requisition No: #{params[:requisition_no]} | "
    end
    if params[:transporter].present? 
      @where_clause += " and transporter_id = #{params[:transporter]}" 
      @result += "Transporter: #{Transporter.find(params[:transporter])&.name} | "
    end
    if params[:reference].present?
      @where_clause += " and transport_order_items.requisition_no IN ( "
      @list_of_requistion_nos = RegionalRequest.includes(:requisitions).where(:reference_number => params[:reference]).pluck(:'requisitions.requisition_no')
      @list_of_requistion_nos.each do |rn|
        if @list_of_requistion_nos.first == rn
          @where_clause += "'#{rn}'"
        else
          @where_clause += ", '#{rn}'"
        end
      end      
      @where_clause += ")"
      @result += "Reference No.: #{params[:reference]}"
    end
    
    @transport_orders = []
    TransportOrder.joins(:location, :transporter, :transport_order_items).where(@where_clause).distinct.each do |to|
      no_of_destinations = to&.transport_order_items.count(:fdp_id)
      total_quantity = to&.transport_order_items.sum(:quantity)
      @transport_orders << { id: to.id, order_no: to.order_no, transporter: to.transporter.name, region: to.location.name, no_of_destinations: no_of_destinations, total_quantity: total_quantity, status: to.status }
    end
  end

  # GET /transport_orders/1
  # GET /transport_orders/1.json
  def show
    @transport_order = TransportOrder.find(params[:id])
    @transport_order_items = TransportOrderItem.where(transport_order_id: @transport_order.id)
  end

  # GET /transport_orders/new
  def new
    @transport_order = TransportOrder.new
  end

  # GET /transport_orders/1/edit
  def edit
  end

  # POST /transport_orders
  # POST /transport_orders.json
  def create
    @transport_order = TransportOrder.new(transport_order_params)

    respond_to do |format|
      if @transport_order.save
        format.html { redirect_to @transport_order, notice: 'Transport order was successfully created.' }
        format.json { render :show, status: :created, location: @transport_order }
      else
        format.html { render :new }
        format.json { render json: @transport_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transport_orders/1
  # PATCH/PUT /transport_orders/1.json
  def update
    respond_to do |format|
      if @transport_order.update(transport_order_params)
        format.html { redirect_to @transport_order, notice: 'Transport order was successfully updated.' }
        format.json { render :show, status: :ok, location: @transport_order }
      else
        format.html { render :edit }
        format.json { render json: @transport_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_orders/1
  # DELETE /transport_orders/1.json
  def destroy
    @transport_order.destroy
    respond_to do |format|
      format.html { redirect_to transport_orders_url, notice: 'Transport order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def print
    @transport_order = TransportOrder.includes(:transporter, :contract, :bid).find(params[:id])

    @transport_order.start_date = params[:transport_order][:start_date]
    @transport_order.end_date = params[:transport_order][:end_date]
    @transport_order.save
 
    @region = Location.find(@transport_order.location_id)&.name
    @zones = []
    @requisitions = ""
    TransportOrderItem.where(:transport_order_id => params[:id])
    .find_each do |toi|
      @zone_name = Fdp.includes(:location).find(toi.fdp_id).location.parent.name
      if (!(@zones.include?(@zone_name)))
        @zones << @zone_name
      end
      @commodity_name = Commodity.find(toi.commodity_id).name
      if (!(@requisitions.include?(toi.requisition_no)))
        @requisitions += "#{@commodity_name}:#{toi.requisition_no}, "
      end
    end
    @transport_order_items_flat = []
    @count = 0
    @amount_total = 0
    @birr_total = 0
    @transport_order_items = TransportOrderItem.includes(:commodity, fdp: :location).where(:transport_order_id => params[:id])
    @transport_order_items.map do |item|
      requisition_id = Requisition.find_by(requisition_no: item.requisition_no)&.id
      # project_id = ProjectCodeAllocation.where(requisition_id: requisition_id).limit(1).pluck(:project_id)
      warehouse_id = WarehouseAllocationItem.where(requisition_id: requisition_id,fdp_id: item.fdp_id).limit(1).pluck(:warehouse_id)
      if warehouse_id.present?
        @warehouse = Warehouse.find_by(id: warehouse_id[0].to_i)&.name
      end
      @count += 1
      target_unit = UnitOfMeasure.find_by(name: "Quintal")
      current_unit = UnitOfMeasure.find(item.unit_of_measure_id)
      amount_in_qtl = target_unit.convert_to(current_unit.name, item.quantity)
      @amount_total = @amount_total + (amount_in_qtl)
      @birr_total = @birr_total + (amount_in_qtl*item.tariff)
      @transport_order_items_flat = @transport_order_items_flat << [@count, item.fdp.location.name, item.fdp.name, @warehouse,item.commodity.name, amount_in_qtl, item.tariff.round(2), (amount_in_qtl*item.tariff).round(2)]  
    end
    @split_birr_total = @birr_total.divmod 1
    puts "split_birr_total: " + @split_birr_total[1].round(2).to_s
    @integer = @split_birr_total[0].humanize + ' birr and'
    @fraction = (@split_birr_total[1]*100).to_i.humanize + ' cents'
    @birr_total_in_words = @integer.to_s + ' ' + @fraction.to_s
    @aggregated = {'amount_total' => @amount_total, 'birr_total' => @birr_total, 'birr_total_inwords' => @birr_total_in_words.humanize} 

    
    @requistion_ids = @transport_order_items.map{|r| r.requisition_no}.uniq
    @references = get_reference_numbers_by_requisition_no(@requistion_ids)
    
    @contract_no = "N/A"
    if (@transport_order&.bid&.bid_number.present? && @transport_order&.transporter&.code.present?)
      @contract_no = "LTCD/#{@transport_order&.bid&.bid_number}/#{@transport_order&.transporter&.code}"
    end
 
    respond_to do |format|
      format.html
      format.pdf do
          pdf = TransportOrderPdf.new(@transport_order, @transport_order_items, @transport_order_items_flat, @zones,  @region, @requisitions, @references, @contract_no, @aggregated)
          send_data pdf.render, filename: "transport_order_#{@transport_order&.id}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end      
    end
  end

  def move
    @transport_order_items_ids = params[:att].split ","
   TransportOrder.move_transport_order(params[:transporter], @transport_order_items_ids,current_user.id)
   respond_to do |format|
        format.html { redirect_to @transport_order, notice: 'Transport order was successfully moved to the new transporter.' }
        format.json { render :show, status: :created, location: @transport_order }
      end
 end

def rrd_reference_list
  @operation_id = params[:operation_id]
  @region_id = params[:region_id]
  @regional_request_references = RegionalRequest.includes(:requisitions).where(:'regional_requests.operation_id' => @operation_id, :'regional_requests.region_id' => @region_id).map{ |r| [r.reference_number, r.id]} 
  
  respond_to do |format|
    format.json {render json: @regional_request_references}
  end
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_order
      @transport_order = TransportOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
     def transport_order_params
      params.require(:transport_order).permit(:order_no, :transporter_id, :contract_id, :bid_id, :operation_id, :location_id, :order_date, :created_date, :start_date, :end_date, :performance_bond_receipt, :performance_bond_amount, :printed_copies, :status)
    end
end
