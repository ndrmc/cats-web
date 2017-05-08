class DeliveriesController < ApplicationController
  before_action :set_delivery, only: [:show, :edit, :update, :destroy]

  # GET /deliveries
  # GET /deliveries.json
  def index
    authorize Delivery
    # @deliveries = Delivery.all

    #  if params[:search]
    #   @deliveries = Post.search(params[:search]).order("created_at DESC")
    #  else
    #   @deliveries = Post.all.order('created_at DESC')
    #  end
    if(params[:operation_id] && params[:region] && !params[:fdp_id].empty?)
       @deliveries = Delivery.filter(params.slice(:region, :fdp_id, :operation_id, :gin_number))
    else
      @deliveries = []
    end

  end


  # GET /deliveries/1
  # GET /deliveries/1.json
  def show
    authorize Delivery
  end

  # GET /deliveries/new
  def new
   authorize Delivery

    @delivery = Delivery.new
    @gin = Dispatch.find_by({'gin_no': params[:gin_number]})
    if(@gin)

      @delivery_exists = Delivery.find_by({'gin_number': params[:gin_number]})

     if(! @delivery_exists)


      @delivery = Delivery.new({
        transporter_id: @gin.transporter_id,
        gin_number: @gin.gin_no,
        requisition_number: @gin.requisition_number,        
        fdp_id: @gin.fdp_id,
        operation_id: @gin.operation_id,
        delivery_details: []
      })



      @delivery.delivery_details = []
      @gin.dispatch_items.each do |item|

        @delivery_detail = DeliveryDetail.new({commodity_id: item.commodity_id,
                                                uom_id: '1',
                                                sent_quantity: item.quantity})

        @delivery.delivery_details.push(@delivery_detail)

       end
      else
        redirect_to new_delivery_path, :flash => { :error => "Delivery Record with the same GIN number already exists!" }
        end
    else
      @gin = Dispatch.new
    end
  end

  # GET /deliveries/1/edit
  def edit
  end

  # POST /deliveries
  # POST /deliveries.json
  def create

    authorize Delivery

    @delivery = Delivery.new(delivery_params)
    @delivery.created_by = current_user.id

    respond_to do |format|
      if @delivery.save
        format.html { redirect_to deliveries_url, notice: 'Delivery was successfully created.' }
        format.json { render :index, status: :created, location: @deliveries }
      else
        format.html { render :new }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deliveries/1
  # PATCH/PUT /deliveries/1.json
  def update

    authorize Delivery

    @delivery = Delivery.find(params[:id]);
    @delivery.delivery_details.destroy_all
    @delivery.modified_by = current_user.id

    respond_to do |format|
      if @delivery.update(delivery_params)
        format.html { redirect_to edit_delivery_url(@delivery), notice: 'Delivery was successfully updated.' }
        format.json { render :edit, status: :ok, location: @delivery }
      else
        format.html { render :edit }
        format.json { render json: @delivery.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deliveries/1
  # DELETE /deliveries/1.json
  def destroy
    authorize Delivery
    @delivery.destroy
    respond_to do |format|
      format.html { redirect_to deliveries_url, notice: 'Delivery was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_delivery
      @delivery = Delivery.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def delivery_params
      params.require(:delivery).permit(:receiving_number, :transporter_id, :primary_plate_number, :trailer_plate_number, :driver_name,
      :fdp_id, :gin_number, :waybill_number, :requisition_number, :received_by, :received_date, :status, :operation_id,
      :delivery_details_attributes => [:id, :commodity_id, :uom_id, :sent_quantity, :received_quantity])


    end
end
