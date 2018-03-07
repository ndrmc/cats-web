class TransportersController < ApplicationController
  before_action :set_transporter, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # GET /transporters
  # GET /transporters.json
  def index
    @transporters = Transporter.all
  end

  # GET /transporters/1
  # GET /transporters/1.json
  def show
    # @transport_order_items = TransportOrderItem.joins(transport_order: [:operation]).
    # joins("LEFT OUTER JOIN bids b on b.id =transport_orderS.bid_id LEFT OUTER JOIN bid_winners bw on bw.bid_id = b.id")
    # .where(:'transport_orders.transporter_id' => params[:id],
    #  :'transport_orders.status'=> :draft) #here status has to be changed to :ongoing
    # .group(:'transport_order_items.transport_order_id', :'operations.id',:'transport_orders.order_no')
    # .select('operations.id as operation_id, sum(bw.tariff_amount) as tarrif_amount, sum(transport_order_items.quantity) as balance, transport_order_items.transport_order_id, transport_orders.order_no as order_no,operations.name as operation')

    @transport_order_items = TransportOrder.joins(:operation, :transport_order_items).where(:'transport_orders.transporter_id' => params[:id], :'transport_orders.status'=> :draft).select('transport_orders.id, operations.id as operation_id, transport_order_items.tariff, transport_order_items.quantity, (transport_order_items.tariff * transport_order_items.quantity) as delivery_price, transport_order_items.transport_order_id, transport_orders.order_no, operations.name as operation').to_a
    
    @transport_orders = []
    TransportOrder.includes(:operation,:transport_order_items).where(:'transport_orders.transporter_id' => params[:id], :'transport_orders.status'=> :draft).each do |to|
      received_qty = 0
      requisition_nos = to.transport_order_items.map { |toi| toi.requisition_no }
      fdp_ids = to.transport_order_items.map { |toi| toi.fdp_id }
      DeliveryDetail.joins(:delivery).where(:'deliveries.transporter_id' => to.transporter_id, :'deliveries.status' => :verified, :'deliveries.requisition_number' => requisition_nos, :'deliveries.fdp_id' => fdp_ids).each do |dd|
        received_qty += UnitOfMeasure.find(dd.uom_id.to_i).to_ref(dd.received_quantity.to_f)
      end     
      tio_filtered = @transport_order_items.select {|i| i.transport_order_id == to.id}
      balance = 0
      est_payment = 0
      tio_filtered.each { |a| balance+=a.quantity }
      tio_filtered.each { |a| est_payment+=a.delivery_price }
      @transport_orders << {'id' => to.id, 'order_no' => to.order_no, 'operation_id' => to.operation_id, 'operation' => to.operation.name, 'balance' => balance,'confirmed_delivery' => received_qty, 'est_payment' => est_payment, 'paid_amount' => 0 }
    end
end

def transporter_fdp_detail
    @requisitions = TransportOrderItem.joins(transport_order: [:operation])
    .where(:'transport_orders.id' => params[:order_id], 
    :'transport_orders.transporter_id' => params[:transporter_id], 
    :'transport_orders.operation_id' => params[:operation_id]).distinct.pluck(:requisition_no)
     @dispatch_summary = Transporter.fdp_allocations(params[:transporter_id], params[:operation_id], @requisitions)  
     @transporter = Transporter.find(params[:transporter_id])
     @order_no = TransportOrder.find(params[:order_id]).order_no
end

def transporter_verify_detail
   @requisitions = TransportOrderItem.joins(transport_order: [:operation])
    .where(:'transport_orders.id' => params[:order_id], 
    :'transport_orders.transporter_id' => params[:transporter_id], 
    :'transport_orders.operation_id' => params[:operation_id]).pluck(:requisition_no)
     @dispatch_summary = Transporter.fdp_verification(params[:transporter_id], params[:operation_id], @requisitions)  
     @dispatch_summary = @dispatch_summary.select { |hash| hash['delivery_status'] == Delivery.statuses.key(Delivery.statuses[:draft]) }
     @transporter = Transporter.find(params[:transporter_id])
     @order_no = TransportOrder.find(params[:order_id]).order_no
end

def processPayment

    @transporter_id = params[:id]
   
    @reference_no = params[:reference_no]
    @payment_date = params[:payment_date]
    @requested_amount = params[:request_amount]
    @remark = params[:remark]

    @payment_request = PaymentRequest.new
    @payment_request.reference_no = @reference_no
    @payment_request.payment_date = @payment_date
    @payment_request.amount_requested = @requested_amount
    @payment_request.remark = @remark
    @payment_request.transporter_id = @transporter_id

    deliveries_with_status_verified =  Delivery.where(:'deliveries.transporter_id' => @transporter_id , :'status' => :verified)
    if deliveries_with_status_verified.present?
                    if (deliveries_with_status_verified.update_all(:'status' => Delivery.statuses[:payment_request_created]))  
                  
                      deliveries_with_status_verified.each do |delivery|
                          delivery.delivery_details.each do |delivery_item|

                          @payment_request_items = PaymentRequestItem.new
                          @payment_request_items.requisition_no = delivery_item&.delivery&.requisition_number
                          @payment_request_items.gin_no = delivery_item&.delivery&.gin_number
                          @payment_request_items.grn_no = delivery_item&.delivery&.receiving_number
                          @payment_request_items.fdp_id = delivery_item&.delivery&.fdp_id
                          @payment_request_items.commodity_id = delivery_item&.commodity_id
                          @payment_request_items.dispatched = delivery_item&.sent_quantity
                          @payment_request_items.received  = delivery_item&.received_quantity
                          @payment_request_items.loss = 0
                          @payment_request_items.tariff = 0
                          @payment_request_items.freightCharge = 0
                          
                          @payment_request.payment_request_items << @payment_request_items
                      end
                    end
                    if  @payment_request.save
                      respond_to do |format|
                            flash[:notice] = "Record has been updated."
                            format.html {  redirect_to :action => 'payment_request' }
                      end
                  end
                end
  else
      respond_to do |format|
                            flash[:alert] = "No verified record found."
                            format.html {  redirect_to request.referrer  }
                      end
  end
  
end

def payment_request
   if params[:reference_no].present?
      @payment_requests = PaymentRequest.where(reference_no: params[:reference_no])
      return
    end

    if params[:transporter].present? && params[:status].present?
      filter_map = {transporter_id: params[:transporter], status: params[:status]}
      @payment_requests = PaymentRequest.where( filter_map )
    else
      @payment_requests = PaymentRequest.all
    end

  
end

def payment__request_items
  @id = params[:id]

  @payment__request_items = PaymentRequestItem.where(payment_request_id: @id)
  if @payment__request_items.present?
      @payment_request_id = @id
      @referenceNo =  @payment__request_items&.first&.payment_request&.reference_no
      @transporter = Transporter.find(@payment__request_items&.first&.payment_request&.transporter_id)
    else
      @payment__request_items =[]
    end
end
def update_status
  grn_no = params[:grn_no]
  status = params[:status]
  @delivery = Delivery.where(receiving_number: grn_no).first
  if @delivery.present?
    @delivery.status = status.to_i
    if @delivery.save
     respond_to do |format|
            flash[:notice] = "Record has been updated."
            format.html {  redirect_to request.referrer }
      end
    else
        respond_to do |format|
            flash[:alert] = "Operation was unsuccessful."
            format.html {  redirect_to request.referrer }
         end
     end
  else
      
        respond_to do |format|
            flash[:alert] = "Operation was unsuccessful."
            format.html {  redirect_to request.referrer }
        end
  end
  
end

  # GET /transporters/new
  def new
    @transporter = Transporter.new
  end

  # GET /transporters/1/edit
  def edit
  end

  # POST /transporters
  # POST /transporters.json
  def create
    @transporter = Transporter.new(transporter_params)
    @transporter.created_by = current_user.id
    respond_to do |format|
      if @transporter.save
        format.html { redirect_to transporters_path, notice: 'Transporter was successfully created.' }
        format.json { render :show, status: :created, location: @transporter }
      else
        format.html { render :new }
        format.json { render json: @transporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transporters/1
  # PATCH/PUT /transporters/1.json
  def update
    respond_to do |format|
      @transporter.modified_by = current_user.id
      if @transporter.update(transporter_params)
        format.html { redirect_to transporter_path @transporter, notice: 'Transporter was successfully updated.' }
        format.json { render :show, status: :ok, location: @transporter }
      else
        format.html { render :edit }
        format.json { render json: @transporter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transporters/1
  # DELETE /transporters/1.json
  def destroy
    @transporter.destroy
    respond_to do |format|
      format.html { redirect_to transporters_url, notice: 'Transporter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_transporter
    @transporter = Transporter.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def transporter_params
    params.require(:transporter).permit(:name, :code, :ownership_type_id, :vehicle_count, :lift_capacity, :capital, :employees, :contact, :contact_phone, :remark, :status)
  end
end
