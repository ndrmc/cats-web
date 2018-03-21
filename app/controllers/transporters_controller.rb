class TransportersController < ApplicationController
  require 'humanize'
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
     
    @delivery_count = Delivery.where(:'transporter_id' => params[:id], :'deliveries.status' => :draft).count
    @payment_request_ids = TransporterPayment.where(:status => :paid).distinct.pluck(:'payment_request_id')
  
    
    @approved_grns = PaymentRequestItem.includes(:payment_request).where('payment_requests.id IN (?) and payment_requests.transporter_id = ?', @payment_request_ids, params[:id]).distinct.pluck(:'payment_request_items.grn_no')
   
    @approved_grns = @approved_grns.map(&:to_s)
    if  @approved_grns.present?
      @delivery_sum = Delivery.joins(:delivery_details).where({:'transporter_id' => params[:id]}).where('receiving_number IN (?)', @approved_grns).sum(:'delivery_details.received_quantity')
    else
       @delivery_sum = 0
    end
    
    @invoice_count = PaymentRequest.where(:'transporter_id' => params[:id], :'payment_requests.status' => :open).count

    @amount_requested =  Transporter.amount_requested(params[:id])

    @transport_order_items = TransportOrder.joins(:operation, :transport_order_items).where(:'transport_orders.transporter_id' => params[:id], :'transport_orders.status'=> :draft).select('transport_orders.id, operations.id as operation_id, transport_order_items.tariff, transport_order_items.quantity, (transport_order_items.tariff * transport_order_items.quantity) as delivery_price, transport_order_items.transport_order_id, transport_orders.order_no, operations.name as operation').to_a
    
    $transport_orders = []
    TransportOrder.includes(:operation,:transport_order_items).where(:'transport_orders.transporter_id' => params[:id], :'transport_orders.status'=> :draft).each do |to|
      received_qty = 0
      requisition_nos = to.transport_order_items.map { |toi| toi.requisition_no }
      fdp_ids = to.transport_order_items.map { |toi| toi.fdp_id }
      DeliveryDetail.joins(:delivery).where(:'deliveries.transporter_id' => to.transporter_id,:'deliveries.requisition_number' => requisition_nos, :'deliveries.fdp_id' => fdp_ids).where('deliveries.status > 0').each do |dd|
        received_qty += UnitOfMeasure.find(dd.uom_id.to_i).to_ref(dd.received_quantity.to_f) 
      end     
      tio_filtered = @transport_order_items.select {|i| i.transport_order_id == to.id}
      balance = 0
      est_payment = 0
      tio_filtered.each { |a| balance+=a.quantity }
      tio_filtered.each { |a| est_payment+=a.delivery_price }
      $transport_orders << {'id' => to.id, 'order_no' => to.order_no, 'operation_id' => to.operation_id, 'operation' => to.operation.name, 'balance' => balance,'confirmed_delivery' => received_qty, 'est_payment' => est_payment, 'paid_amount' => 0 }
    end
end

def transporter_fdp_detail
    @transport_order =[]
    @requisitions = TransportOrderItem.joins(transport_order: [:operation])
    .where(:'transport_orders.id' => params[:order_id], 
    :'transport_orders.transporter_id' => params[:transporter_id], 
    :'transport_orders.operation_id' => params[:operation_id]).distinct.pluck(:requisition_no)
     @dispatch_summary = Transporter.fdp_allocations(params[:transporter_id], params[:operation_id], @requisitions)  
     @transporter = Transporter.find(params[:transporter_id])
     @order_no = TransportOrder.find(params[:order_id])
     $transport_orders.each do | to |
       @transport_order << to if to['id'].to_i == params[:order_id].to_i
    end
end

def transporter_verify_detail
  @transport_order =[]

   @requisitions = TransportOrderItem.joins(transport_order: [:operation])
    .where(:'transport_orders.id' => params[:order_id], 
    :'transport_orders.transporter_id' => params[:transporter_id], 
    :'transport_orders.operation_id' => params[:operation_id]).pluck(:requisition_no)
     @dispatch_summary = Transporter.fdp_verification(params[:transporter_id], params[:operation_id], @requisitions)  
     @dispatch_summary = @dispatch_summary.select { |hash| hash['delivery_status'] == Delivery.statuses.key(Delivery.statuses[:draft]) ||
     hash['delivery_status'] == Delivery.statuses.key(Delivery.statuses[:verified])  ||  hash['delivery_status'] == Delivery.statuses.key(Delivery.statuses[:reverted])  }
     @transporter = Transporter.find(params[:transporter_id])
     @order_no = TransportOrder.find(params[:order_id])
     if  $transport_orders.present?
      $transport_orders.each do | to |
       @transport_order << to if to['id'].to_i == params[:order_id].to_i
    end
  end
end

def set_market_price
  @delivery_detail = DeliveryDetail.find(transporter_params['delivery_detail_id'])
  @delivery_detail.market_price = transporter_params['market_price']
  respond_to do |format|
    if(@delivery_detail.save)
      flash[:notice] = "Market price is saved successfully."
      format.html {  redirect_to request.referrer  }
    else
      flash[:alert] = "Market price not saved."
      format.html {  redirect_to request.referrer  }
    end    
  end
end

def dispatches_list_per_fdp
  @transport_order =[]
  @transporter = Transporter.find(params[:transporter_id])
  @operation = Operation.find(params[:operation_id])
  @order_no = TransportOrder.find(params[:order_id])
  @dispatches_list_per_fdp = Transporter.dispatches_list_per_fdp(params[:transporter_id], params[:operation_id], params[:requisition_no], params[:fdp_id])

  @order_no = TransportOrder.find(params[:order_id])
  if  $transport_orders.present?
    $transport_orders.each do | to |
      @transport_order << to if to['id'].to_i == params[:order_id].to_i
    end
  end
end

def reject_payment_request
  flag = 0
  @reference_no = params[:reference_no]
  @payment_request = PaymentRequest.where(reference_no: @reference_no).first
  @payment_request.payment_request_items.each do | item |
    @delivery = Delivery.where(receiving_number: item.grn_no).first
    @delivery.status = Delivery.statuses[:verified]
    @delivery.save
    flag = 1
  end
  if flag
     if  @payment_request.destroy
                      respond_to do |format|
                            flash[:notice] = "Payment request has been reveresed."
                            format.html {  redirect_to :action => 'payment_request' }
                      end
     else
            respond_to do |format|
                            flash[:alert] = "Payment request has not been reveresed.."
                            format.html {  redirect_to :action => 'payment_request' }
                      end
     end

  else
    respond_to do |format|
                            flash[:alert] = "Payment request has not been reveresed.."
                            format.html {  redirect_to :action => 'payment_request' }
                      end
  end
  
end
def get_tariff (transport_id, fdp_id, requisition_no)
    @tariff  = TransportOrderItem.includes(:transport_order).where(:'transport_orders.transporter_id' => transport_id, :fdp_id => fdp_id, :requisition_no => requisition_no).select('tariff').first
end

def processPayment

    @transporter_id = params[:id]
   
    @reference_no = params[:reference_no]
    @payment_date = params[:request_date]
    @requested_amount = params[:amount_requested]
    @remark = params[:remark]

    @payment_request = PaymentRequest.new
    @payment_request.reference_no = @reference_no
    @payment_request.payment_date = @payment_date
    @payment_request.amount_requested = @requested_amount
    @payment_request.remark = @remark
    @payment_request.transporter_id = @transporter_id
    @payment_request.status = :open
    @deliveries_with_status_verified =  Delivery.where(:'deliveries.transporter_id' => @transporter_id , :'status' => :verified)
    if @deliveries_with_status_verified.present?
                    if (@deliveries_with_status_verified.update_all(:'status' => Delivery.statuses[:payment_request_created]))  
                  
                     @deliveries_with_status_verified.each do |delivery|
                          delivery.delivery_details.each do |delivery_item|
                            
                          received_qty = UnitOfMeasure.find(delivery_item&.uom_id.to_i).to_ref(delivery_item&.received_quantity.to_f)

                          @tariff = get_tariff(  @transporter_id, delivery_item&.delivery&.fdp_id,delivery_item&.delivery&.requisition_number)
                     
                          
                          @payment_request_items = PaymentRequestItem.new
                          @payment_request_items.requisition_no = delivery_item&.delivery&.requisition_number
                          @payment_request_items.gin_no = delivery_item&.delivery&.gin_number
                          @payment_request_items.grn_no = delivery_item&.delivery&.receiving_number
                          @payment_request_items.fdp_id = delivery_item&.delivery&.fdp_id
                          @payment_request_items.hub_id = Dispatch.find_by(gin_no: delivery_item&.delivery&.gin_number)&.hub_id
                          @payment_request_items.commodity_id = delivery_item&.commodity_id
                          @payment_request_items.unit_of_measure_id = delivery_item&.uom_id
                          @payment_request_items.dispatched = delivery_item&.sent_quantity
                          @payment_request_items.received  = delivery_item&.received_quantity
                          @payment_request_items.loss = delivery_item&.loss_quantity
                          @payment_request_items.tariff =  @tariff&.tariff
                          @payment_request_items.freightCharge = (@tariff&.tariff.to_s.to_d * delivery_item&.received_quantity.to_s.to_d * 10) - (delivery_item.loss_quantity * 10 * delivery_item.market_price)
                          @payment_request_items.transport_order_id = @transport_order_id

                          @payment_request.payment_request_items << @payment_request_items
                      end
                    end
                    if  @payment_request.save
                      respond_to do |format|
                            flash[:notice] = "Payment request has been processed."
                            format.html {  redirect_to :action => 'payment_request' }
                      end
                  end
                end
  else
      respond_to do |format|
                            flash[:alert] = "No verified payment request was found."
                            format.html {  redirect_to request.referrer  }
                      end
  end
  
end
def print_payment_request
      transporter_id = params[:transporter_id]
      @payment_requested =  PaymentRequestItem.includes(:payment_request).where(:'payment_requests.transporter_id' => transporter_id, :'payment_requests.status' => :open)
      @received = @payment_requested.sum(:received)
      @dispatched = @payment_requested.sum(:dispatched )
      @freight_charge = @payment_requested.sum(:freightCharge)
      @loss_quantity = @payment_requested.sum(:loss)
      @transporter = Transporter.find_by(id: @payment_requested.first&.payment_request&.transporter_id)&.name
       respond_to do |format|
            format.html
            format.pdf do
                pdf = PaymentRequestPdf.new(@payment_requested,@dispatched,@received,@freight_charge, @transporter, @current_user.first_name)
                send_data pdf.render, filename: "payment_request.pdf",
                type: "application/pdf",
                disposition: "inline"
            end
            
        end
end

def print_payment_request_letter
     transporter_id = params[:transporter_id]
      @payment_requested =  PaymentRequestItem.includes(:payment_request).where(:'payment_requests.transporter_id' => transporter_id, :'payment_requests.status' => :open)
    
      @received = @payment_requested.sum(:received)
      @dispatched = @payment_requested.sum(:dispatched )
      @freight_charge = @payment_requested.sum(:freightCharge)
      @loss_quantity = @payment_requested.sum(:loss)
      @freight_charge_in_words = @freight_charge.humanize(decimals_as: :digits)
      @transporter = Transporter.find_by(id: @payment_requested.first&.payment_request&.transporter_id)&.name
       respond_to do |format|
            format.html
            format.pdf do
                pdf = PaymentRequestLetterPdf.new(@payment_requested,@dispatched,@received,@freight_charge, @transporter, @current_user.first_name, @loss_quantity, @freight_charge_in_words)
                send_data pdf.render, filename: "payment_request_letter.pdf",
                type: "application/pdf",
                disposition: "inline"
            end
            
        end
end

def payment_request
   if params[:reference_no].present?
      @payment_requests = PaymentRequest.where(reference_no: params[:reference_no])
      return
    end
    
    if params[:transporter].present?
      @payment_requests = PaymentRequest.where(transporter_id: params[:transporter])
      return
    end

    if params[:transporter].present? && params[:status].present?
      filter_map = {transporter_id: params[:transporter], status: params[:status]}
      @payment_requests = PaymentRequest.where( filter_map )
    else
      @payment_requests = PaymentRequest.all
    end

  
end

def payment_request_items
  @id = params[:id]
  @amount_paid = 0
  @payment_request = PaymentRequest.find(@id)
  # @payment_request_items = PaymentRequestItem.where(payment_request_id: @id)
  
  @payment_request_items = []
  PaymentRequestItem.where(payment_request_id: @id).each do |pri|

    @qtl = UnitOfMeasure.find_by(name: 'Quintal')
    if (pri.unit_of_measure_id?)
      @unit_to_be_changed = UnitOfMeasure.find_by(id: pri.unit_of_measure_id).name
    else
      @unit_to_be_changed = UnitOfMeasure.find_by(code: 'MT').name
    end
    dispatched = @qtl.convert_to(@unit_to_be_changed, pri.dispatched)
    received = @qtl.convert_to(@unit_to_be_changed, pri.received)
    loss = @qtl.convert_to(@unit_to_be_changed, pri.loss)

    @amount_paid += pri.freightCharge

    @payment_request_items << { reference_no: @payment_request.reference_no, requisition_no: pri.requisition_no, gin_no: pri.gin_no, grn_no: pri.grn_no, commodity: pri&.commodity&.name, hub: pri&.hub&.name, fdp: pri&.fdp&.name, dispatched: dispatched, received: received, loss: loss, tariff: pri.tariff, freightCharge: pri.freightCharge }
  end

  if @payment_request_items.present?
    @payment_request_id = @id
    @referenceNo =  @payment_request&.reference_no
    @transporter = Transporter.find(@payment_request&.transporter_id)
  end
end

def update_status_all
  @transporter_id = params[:transporter_id]
  @status_type = params[:type]
  @order_no =params[:order_no]
  @count = 0
 if params[:type].present?
  if @status_type == 'verify'
    deliveries_with_status_verified =  Delivery.where('deliveries.transporter_id = ?', @transporter_id).where('status = ? or status = ?',Delivery.statuses[:draft], Delivery.statuses[:reverted])
      if deliveries_with_status_verified.present?
        deliveries_with_status_verified.each do |delivery|
          delivery.delivery_details.each do |item|
                if item.sent_quantity.to_f == (item.received_quantity.to_f + item.loss_quantity.to_f)
                      item.delivery.update(:'status' => Delivery.statuses[:verified])
                else
                      @count = @count + 1
                end 
            end
      end
      if @count > 0
              
                    respond_to do |format|
                    flash[:alert] =  @count.to_s + "  payment request(s) are not updated"
                    flash[:notice] =  "Payment request has been verified"
                    format.html {  redirect_to request.referrer }
                    end
            else
                    respond_to do |format|
                    flash[:notice] =  "Payment request has been verified"
                    format.html {  redirect_to request.referrer }
                    end        
            end
              
      else
          respond_to do |format|
          flash[:alert] = "There are no deliveries to be verified."
          format.html {  redirect_to request.referrer }
      end
    end
  elsif @status_type == 'revert'
        deliveries_with_status_verified =  Delivery.where(:'deliveries.transporter_id' => @transporter_id , :'status' => :verified)
        if deliveries_with_status_verified.present?
                        if (deliveries_with_status_verified.update_all(:'status' => Delivery.statuses[:draft]))  
                               respond_to do |format|
                                  flash[:notice] = "Payment request(s) have been reverted to Draft."
                                  format.html {  redirect_to request.referrer }
                            end
                        end
        else
          respond_to do |format|
            flash[:alert] = "There are no deliveries to be Revereted."
            format.html {  redirect_to request.referrer }
        end
      end
  end
else
  respond_to do |format|
            flash[:alert] = "Deliveries were not updated. Please check the data and try again"
            format.html {  redirect_to request.referrer }
        end
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
            flash[:notice] = "Payment request has been updated."
            format.html {  redirect_to request.referrer }
      end
    else
        respond_to do |format|
            flash[:alert] = "Paymant was not updated."
            format.html {  redirect_to request.referrer }
         end
     end
  else
      
        respond_to do |format|
            flash[:alert] = "Paymant was not updated."
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
    params.require(:transporter).permit(:name, :code, :ownership_type_id, :vehicle_count, :lift_capacity, :capital, :employees, :contact, :contact_phone, :remark, :status, :delivery_detail_id, :market_price)
  end
end
