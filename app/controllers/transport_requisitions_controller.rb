class TransportRequisitionsController < ApplicationController
  include TransportRequisitionsHelper
  before_action :set_transport_requisition, only: [:edit, :update, :destroy]

  # GET /transport_requisitions
  # GET /transport_requisitions.json
  def index
    if (params[:operation_id].to_s == '' || params[:operation_id].to_s == nil)
      @operation_id = Operation.all.order(:name).first.id
    else
      @operation_id = params[:operation_id]
    end
    @transport_requisitions = TransportRequisition.joins('INNER JOIN transport_requisition_items ON transport_requisitions.id = transport_requisition_items.transport_requisition_id INNER JOIN locations ON locations.id = transport_requisitions.location_id').select('transport_requisitions.id, transport_requisitions.operation_id, transport_requisitions.reference_number, transport_requisitions.reference_number, transport_requisitions.location_id, locations.name AS region_name, transport_requisitions.created_at, transport_requisitions.status, sum(transport_requisition_items.quantity) as total_qty, count(transport_requisition_items.id) as destinations').where('transport_requisitions.operation_id = ' + @operation_id.to_s).group('transport_requisitions.id, transport_requisitions.operation_id, transport_requisitions.reference_number, transport_requisitions.reference_number, transport_requisitions.location_id, locations.name, transport_requisitions.created_at, transport_requisitions.status')
  end

  # GET /transport_requisitions/1
  # GET /transport_requisitions/1.json
  def show
    @transport_requisition = TransportRequisition.includes(transport_requisition_items: [:commodity, fdp: :location, requisition: [:region, :zone] ]).find(params[:id])
    @tri_aggregate_by_zone = TransportRequisitionItem.includes(:commodity, fdp: :location, requisition: [:region, :zone]).where(:transport_requisition_id => params['id']).group(:requisition_id, :'requisitions.requisition_no', :'commodities.name', :'regions_requisitions.name', :'zones_requisitions.name').sum(:quantity)
  end

  # GET /transport_requisitions/new
  def new
    @transport_requisition = TransportRequisition.new
  end

  # GET /transport_requisitions/1/edit
  def edit
  end

  # POST /transport_requisitions
  # POST /transport_requisitions.json
  def create
    @result = TransportRequisition.generate_tr(transport_requisition_params, current_user.id)
    
    respond_to do |format|
      if (@result.present?)
        format.html { redirect_to transport_requisitions_url('en',@result), notice: 'Transport requisition was successfully created.' }
        format.json { render json: { :successful => true }}
      else
        format.html { render :new }
        format.json { render json: { :errors => 'Transport Requisition is not created.'}, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transport_requisitions/1
  # PATCH/PUT /transport_requisitions/1.json
  def update
    respond_to do |format|
      if @transport_requisition.update(transport_requisition_params)
        format.html { redirect_to transport_requisitions_url('en',@transport_requisition), notice: 'Transport requisition was successfully updated.' }
        format.json { render :show, status: :ok, location: @transport_requisition }
      else
        format.html { render :edit }
        format.json { render json: @transport_requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transport_requisitions/1
  # DELETE /transport_requisitions/1.json
  def destroy
    @transport_requisition.destroy
    respond_to do |format|
      format.html { redirect_to transport_requisitions_url('en'), notice: 'Transport requisition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_requisition
      @transport_requisition = TransportRequisition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transport_requisition_params
      params.require(:transport_requisition).permit(:reference_number, :location_id, :operation_id, :certified_by, :certified_date, :description, :status, :deleted_by, :deleted_at)
    end
end