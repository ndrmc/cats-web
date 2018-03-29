class Api::OperationsController < Api::ApiController
  before_action :set_operation, only: [:update, :destroy]

  def index
    render json: Operation.all
  end

  def create
    @operation = Operation.create!(operation_params)
    json_response(@operation, :created)
  end

  def update
    @operation.update(operation_params)
    head :no_content
  end

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

    @delivery_commodites = []
    if @deliveries
      @deliveries_map = @deliveries.group_by { |d| d.fdp.region }
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
      @dispatches_map = @dispatches.group_by { |d| d.fdp&.region }
    end

    @dispatch_summary_region = {}

    # find sum total of amount by commodity within a region
    @dispatches_map.each do |region, dispatch_list|
      @dispatch_summary_region = {}
      @commodities.each do |c|
        dispatch_list.each do |dispatch|
          sum = dispatch.dispatch_items.select { |item| item.commodity_id == c.id }.sum(&:quantity)
          @dispatch_summary_region[c.id] = @dispatch_summary_region[c.id] ? @dispatch_summary_region[c.id] + sum : sum
        end
      end
      @dispatches_map[region] = @dispatch_summary_region
    end

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
      @requisition_summary_region = {}
      @commodities.each do |c|
        sum = 0
        requisition_list.select { |r| r.commodity_id == c.id }.each do |req|
          sum = req.requisition_items.sum(&:amount)
        end

        @requisition_summary_region[c.id] = @requisition_summary_region[c.id] ? @requisition_summary_region[c.id] + sum : sum
      end
      @requisitions_map[region] = @requisition_summary_region
    end
  end

  def destroy
    @operation.destroy
    head :no_content
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_operation
    @operation = Operation.find(params[:id])
  end

  def operation_params
    params.permit(:name, :program_id, :year, :month, :status, :hrd_id,:fscd_annual_plan_id, :ration_id)
  end

end
