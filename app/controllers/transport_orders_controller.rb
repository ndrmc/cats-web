class TransportOrdersController < ApplicationController
  before_action :set_transport_order, only: [:show, :edit, :update, :destroy]
 include ReferenceHelper
  # GET /transport_orders
  # GET /transport_orders.json
  def index
     if params[:order_no].present?
      @transport_orders = TransportOrder.where(order_no: params[:order_no]).includes(:bid, :location)
      return
    end

    if params[:transporter].present? && params[:operation].present?
      filter_map = {transporter_id: params[:transporter], operation_id: params[:operation]}
      @transport_orders = TransportOrder.where( filter_map ).includes(:bid, :location)
    else
      @transport_orders = TransportOrder.all.includes(:bid, :location)
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
 
    @region = Location.find(@transport_order.location_id)&.name
    @zones = []
    @commodities = []
    @requisitions = []
    TransportOrderItem.where(:transport_order_id => params[:id])
    .find_each do |toi|
      @zone_name = Fdp.includes(:location).find(toi.fdp_id).location.parent.name
      if (!(@zones.include?(@zone_name)))
        @zones << @zone_name
      end
      @commodity_name = Commodity.find(toi.commodity_id).name
      if (!(@commodities.include?(@commodity_name)))
        @commodities << @commodity_name
      end
      if (!(@requisitions.include?(toi.requisition_no)))
        @requisitions << toi.requisition_no
      end
    end
    @transport_order_items = TransportOrderItem.includes(:commodity, fdp: :location).where(:transport_order_id => params[:id])
      @requistion_ids = @transport_order_items.map{|r| r.requisition_no}.uniq
      @references = get_reference_numbers_by_requisition_no(@requistion_ids)
 
    respond_to do |format|
      format.html
      format.pdf do
          pdf = TransportOrderPdf.new(@transport_order, @transport_order_items, @zones,  @region,@commodities, @requisitions,@references)
          send_data pdf.render, filename: "transport_order_#{@transport_order&.id}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end      
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
