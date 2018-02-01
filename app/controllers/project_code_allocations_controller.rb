class ProjectCodeAllocationsController < ApplicationController
  before_action :set_project_code_allocation, only: [:edit, :update, :destroy]

  # GET /project_code_allocations
  # GET /project_code_allocations.json
  def index
    if(params[:operation].present? && params[:region].present?)
      @zone_ids = Location.find(params[:region]).descendants.where( location_type: :zone).map { |d| d.id }
      @requisitions = Requisition.includes(:requisition_items, :commodity, :project_code_allocations, :zone, ration: :ration_items).where(operation_id: params[:operation], zone_id: @zone_ids)
    else
      @requisitions = []
    end
    @organizations = Organization.order(:name)
    @projects = Project.where('archived = ? OR archived IS NULL',false)
    @unit_of_measures = UnitOfMeasure.order(:name)
    @commodities = Commodity.order(:name)
    @stores = Store.order(:name)
  end

  # GET /project_code_allocations/1
  # GET /project_code_allocations/1.json
  def show
    @requisition = Requisition.includes(:commodity, :project_code_allocations, :zone, ration: :ration_items, requisition_items: [fdp: :location]).find(params[:id])
    @organizations = Organization.order(:name)
    @projects = Project.where('archived = ? OR archived IS NULL',false)
    @unit_of_measures = UnitOfMeasure.order(:name)
    @commodities = Commodity.order(:name)
    @stores = Store.order(:name)
    @project_code_allocations = ProjectCodeAllocation.includes(:hub, :warehouse, :store, :project, :unit_of_measure).where(:requisition_id => params[:id])
  end

  # GET /project_code_allocations/new
  def new
    @project_code_allocation = ProjectCodeAllocation.new
  end

  # GET /project_code_allocations/1/edit
  def edit
  end

  # POST /project_code_allocations
  # POST /project_code_allocations.json
  def create
    @project_code_allocation = ProjectCodeAllocation.new(project_code_allocation_params)

    respond_to do |format|
      if @project_code_allocation.save
        format.html { redirect_to @project_code_allocation, notice: 'Project code allocation was successfully created.' }
        format.json { render :show, status: :created, location: @project_code_allocation }
      else
        format.html { render :new }
        format.json { render json: @project_code_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  def create_for_requisition
   
      @unit_of_measure_id = project_code_allocation_params["unit_of_measure"]
      @amount = project_code_allocation_params["amount"]
      @requested_amount_to_ref = UnitOfMeasure.find(@unit_of_measure_id).to_ref(@amount.to_f)
      pc_allocation = ProjectCodeAllocation.new
    
      pc_allocation.hub_id = project_code_allocation_params["hub"]
      pc_allocation.warehouse_id = project_code_allocation_params["warehouse"]
      pc_allocation.store_id = project_code_allocation_params["store"]
      pc_allocation.operation_id = project_code_allocation_params["operation_id"]
      pc_allocation.requisition_id = project_code_allocation_params["requisition_id"]
      pc_allocation.amount = @requested_amount_to_ref
      pc_allocation.unit_of_measure_id = UnitOfMeasure.where(:code => 'MT').first.id
      pc_allocation.project_id = project_code_allocation_params["project"]
      pc_allocation.hub_id = project_code_allocation_params["hub"]
      pc_allocation.save
    
    
    respond_to do |format|
      format.html { redirect_back fallback_location: project_code_allocations_url, notice: 'Project code allocations were successfully created.' }
      format.json { render :show, status: :created, location: @project_code_allocation }
    end
  end

  # PATCH/PUT /project_code_allocations/1
  # PATCH/PUT /project_code_allocations/1.json
  def update
    respond_to do |format|
      if @project_code_allocation.update(project_code_allocation_params)
        format.html { redirect_to @project_code_allocation, notice: 'Project code allocation was successfully updated.' }
        format.json { render :show, status: :ok, location: @project_code_allocation }
      else
        format.html { render :edit }
        format.json { render json: @project_code_allocation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /project_code_allocations/1
  # DELETE /project_code_allocations/1.json
  def destroy
    @project_code_allocation.destroy
    respond_to do |format|
      format.html { redirect_to project_code_allocations_url, notice: 'Project code allocation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

 def destroy_project_code_allocations
    
      project_code_allocations = ProjectCodeAllocation.where(requisition_id: params["id"])
      project_code_allocations.destroy_all
   
    
    respond_to do |format|
      format.html { redirect_back fallback_location: project_code_allocations_url, notice: 'Project code allocations were successfully destroyed.' }
      format.json { render :show, status: :created, location: @project_code_allocation }
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project_code_allocation
      @project_code_allocation = ProjectCodeAllocation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_code_allocation_params
      params.require(:project_code_allocation).permit(:hub_id, :hub, :warehouse_id, :warehouse, :store_id, :store, :operation_id, :requisition_id, :amount, :unit_of_measure_id, :unit_of_measure, :fdp_id, :project_id, :project)
    end
end
