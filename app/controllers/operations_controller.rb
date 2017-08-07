class OperationsController < ApplicationController
  before_action :set_operation, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /operations
  # GET /operations.json
  def index
     if params[:status]
        @operations = Operation.where status: params[:status]
     else
        @operations = Operation.all 
     end 
   
  end

  # GET /operations/1
  # GET /operations/1.json
  def show
    @operation = Operation.find(params[:id])
    # find the ration for current operation
    @ration = Ration.find(@operation.ration_id)
    @commodities = []
    @ration.ration_items.each do |ration_item|
      @commodities << Commodity.find(ration_item.commodity_id)
    end

    # Find all deliveries within current operation
    @deliveries = Delivery.where(operation_id: params[:id]).includes(:delivery_details, :fdp)
    # group deliveries by region
   
   @delivery_commodites =[]
    if @deliveries
      @deliveries_map = @deliveries.group_by { |d| d.fdp.region}
      @deliveries.map(&:delivery_details).each do |d| 
         @delivery_commodites << d.map(&:commodity_id).first         
        end

    end
    @delivery_commodites.uniq!

    # find sum total of amount by commodity within a region

    @deliveries_map.each do |region, d_list|
      @delivery_summary_region = {}
      @commodities.each do |c|
     
          d_list.each do |delivery|
            sum = delivery.delivery_details.select { |detail| detail.commodity_id == c.id }.sum(&:received_quantity)
            @delivery_summary_region[c.id] = @delivery_summary_region[c.id] ? @delivery_summary_region[c.id] + sum : sum
          end
       
      end
      @deliveries_map[region] = @delivery_summary_region
    end

    # Find all dispatches within current operation
    @dispatches = Dispatch.where(operation_id: params[:id]).includes(:dispatch_items, :fdp)
    # group dispatches by region
    if @dispatches
      @dispatches_map = @dispatches.group_by { |d| d.fdp.region }

    end

    @dispatch_summary_region = {}

    # find sum total of amount by commodity within a region
    @dispatches_map.each do |region, dispatch_list|
      @dispatch_summary_region={}
      @commodities.each do |c|

        dispatch_list.each do |dispatch|
          sum = dispatch.dispatch_items.select { |item| item.commodity_id == c.id }.sum(&:quantity)
          @dispatch_summary_region[c.id] = @dispatch_summary_region[c.id] ? @dispatch_summary_region[c.id] + sum : sum
        end

      end
      @dispatches_map[region] = @dispatch_summary_region
    end

    @operation_name = @operation.name
    @dispatch_report_cols = [ 'Region', 'Allocated', 'Dispatched', 'Progress' ]
    @dispatch_report = Reports.new.dispatch_reports_by_region @operation.id

     # Find all regioal requests within current operation
    @regional_requests = RegionalRequest.where(operation_id: params[:id]).includes(:regional_request_items)

     # Find all requisistions within current operation
    @requisitions = Requisition.where(operation_id: params[:id]).includes(:requisition_items)
    # group dispatches by region
    if @requisitions
      @requisitions_map = @requisitions.group_by { |d| d.region }
    end

    @requisition_summary_region = {}

    # find sum total of amount by commodity within a region
    @requisitions_map.each do |region, requisition_list|
      @requisition_summary_region={}
      @commodities.each do |c|
        sum = 0;
        requisition_list.select{|r| r.commodity_id == c.id }.each do |req|
          sum = req.requisition_items.sum(&:amount) 
        end          
         
        @requisition_summary_region[c.id] = @requisition_summary_region[c.id] ? @requisition_summary_region[c.id] + sum : sum        

      end
      @requisitions_map[region] = @requisition_summary_region
    end
  end

  # GET /operations/new
  def new
    @operation = Operation.new
  end

  # GET /operations/1/edit
  def edit
  end

  # POST /operations
  # POST /operations.json
  def create
    @operation = Operation.new(operation_params)
    @operation.created_by = current_user.id
    respond_to do |format|
      if @operation.save
        format.html { redirect_to @operation, notice: 'Operation was successfully created.' }
        format.json { render :show, status: :created, location: @operation }
      else
        format.html { render :new }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /operations/1
  # PATCH/PUT /operations/1.json
  def update

    @operation.modified_by = current_user.id
    respond_to do |format|
      if @operation.update(operation_params)
        format.html { redirect_to @operation, notice: 'Operation was successfully updated.' }
        format.json { render :show, status: :ok, location: @operation }
      else
        format.html { render :edit }
        format.json { render json: @operation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /operations/1
  # DELETE /operations/1.json
  def destroy

    @operation.destroy
    respond_to do |format|
      format.html { redirect_to operations_url, notice: 'Operation was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def operation_params
    params.require(:operation).permit(:name, :program_id, :year, :month, :status, :hrd_id,:fscd_annual_plan_id, :ration_id)
  end
end
