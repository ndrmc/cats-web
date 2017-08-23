class TransportRequisitionsController < ApplicationController
  include TransportRequisitionsHelper
  before_action :set_transport_requisition, only: [:show, :edit, :update, :destroy]

  # GET /transport_requisitions
  # GET /transport_requisitions.json
  def index
    if (params[:operation_id].to_s == '' || params[:operation_id].to_s == nil)
      @operation_id = Operation.all.order(:name).first.id
    else
      @operation_id = params[:operation_id]
    end
    @transport_requisitions = TransportRequisition.where(:operation_id => @operation_id)
  end

  # GET /transport_requisitions/1
  # GET /transport_requisitions/1.json
  def show
    @transport_requisition = TransportRequisition.find(params[:id])
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
    result = generate_tr(transport_requisition_params)

    respond_to do |format|
      if result
        format.html { redirect_to transport_requisitions_url('en',@transport_requisition), notice: 'Transport requisition was successfully created.' }
        format.json { render :show, status: :created, location: @transport_requisition }
      else
        format.html { render :new }
        format.json { render json: @transport_requisition.errors, status: :unprocessable_entity }
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
