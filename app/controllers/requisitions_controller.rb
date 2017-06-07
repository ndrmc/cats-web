class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /requisitions
  # GET /requisitions.json
  def index
    if(params[:operation].present? && params[:region].present?)
      @requisitions = Requisition.filter(params.slice(:operation, :region, :status))
    else
      @requisitions = []
    end
  end



  # GET /requisitions/new
  def new
    @requisition = Requisition.new
  end

  # GET /requisitions/1/edit
  def edit
  end



  # PATCH/PUT /requisitions/1
  # PATCH/PUT /requisitions/1.json
  def update
    respond_to do |format|
      if @requisition.update(requisition_params)
        format.html { redirect_to edit_requisition_path(@requisition), notice: 'Requisition was successfully updated.' }
        format.json { render :edit, status: :ok, location: @requisition }
      else
        format.html { render :edit }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requisitions/1
  # DELETE /requisitions/1.json
  def destroy
    @requisition.destroy
    respond_to do |format|
      format.html { redirect_to requisitions_url, notice: 'Requisition was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def get_requisiton_by_number
    requisition = Requisition.find_by_requisition_no params[:requisition_no]
    respond_to do |format|
      if requisition
        format.json { render json: { requisition: requisition }}
      else
        format.json { render json: { }, status: 404}
      end
    end
  end

  # PREPARE /requisitions/prepare?request_id=1
  def prepare
    @request = RegionalRequest.find(params[:request_id])
    @requests_per_zone = @request.regional_request_items.group_by { |ri| Fdp.find(ri.fdp_id).location.ancestors.find { |a| a.location_type == 'zone' } }
    @operation = Operation.find(@request.operation_id)

    @ration = Ration.find(@operation.ration_id)
    @commodities = []
    @ration.ration_items.each do |ration_item|
      @commodities << Commodity.find(ration_item.commodity_id)
    end
  end

  def generate

    @request = RegionalRequest.find(params[:request_id])
    if(!@request.generated)
      @operation = Operation.find(@request.operation_id)
      @ration_items = RationItem.where({ration_id: @operation.ration_id})
      @requests_per_zone = @request.regional_request_items.group_by { |ri| Fdp.find(ri.fdp_id).location.ancestors.find { |a| a.location_type == 'zone' }.id }
      @requisition = {}

      params[:zonal_request].each do |zonal_req|

        zonal_req[:commodity_ids].each do |commodity_id|
          @requisition_items = []
          zone_id = zonal_req[:zone_id]

          @requests_per_zone[Integer(zone_id)].each do |request_item|

            requisition_item = RequisitionItem.new({
                                                     fdp_id: request_item[:fdp_id],
                                                     beneficiary_no: request_item[:number_of_beneficiaries],
                                                     amount: @ration_items.select { |hash| hash[:commodity_id] == Integer(commodity_id) }.first.amount*request_item[:number_of_beneficiaries]
            })
            @requisition_items << requisition_item

          end
          @requisition = Requisition.new({
                                           request_id: params[:request_id],
                                           requisition_no: SecureRandom.uuid,
                                           operation_id: @request.operation_id,
                                           commodity_id: commodity_id,
                                           region_id: @request.region_id,
                                           zone_id: zone_id,
                                           ration_id: Operation.find(@request.operation_id).ration_id,
                                           requested_on: @request.requested_date,
                                           status: 'draft',
                                           requisition_items: @requisition_items
          })

          @requisition.created_by = current_user.id

          if(@requisition.save)
            @request.generated = true
            @request.save
          else
            redirect_to RegionalRequest.find(params[:request_id]), :flash => { error: :unprocessable_entity }

          end

        end

      end
      render :js => "window.location = '/requisitions/summary?region=#{@request.region_id}&operation=#{@request.operation_id}' ,
                    window.success = 'Requisitions generated' "
    else

      render :js => "window.location = '/regional_requests/#{params[:request_id]}',
                    window.error = 'Requisitions already generated' "
    end
  end

  def add_requisition

    @request = RegionalRequest.find(params[:request])

    @operation = Operation.find(@request.operation_id)
    @ration_items = RationItem.where({ration_id: @operation.ration_id})
    @request_items_for_zone = @request.regional_request_items.select { |ri| Fdp.find(ri.fdp_id).location.ancestors.find { |a| a.id == Integer(params[:zone]) } }

    @requisition = {}
    @requisition_items = []

    zone_id = Integer(params[:zone])

    @request_items_for_zone.each do |request_item|
      requisition_item = RequisitionItem.new({
                                               fdp_id: request_item[:fdp_id],
                                               beneficiary_no: request_item[:number_of_beneficiaries],
                                               amount: @ration_items.select { |hash| hash[:commodity_id] == Integer(params[:commodity]) }.first.amount*request_item[:number_of_beneficiaries]
      })
      @requisition_items << requisition_item
    end

    @requisition = Requisition.new({
                                     request_id: params[:request],
                                     requisition_no: SecureRandom.uuid,
                                     operation_id: @request.operation_id,
                                     commodity_id: Integer(params[:commodity]),
                                     region_id: @request.region_id,
                                     zone_id: zone_id,
                                     ration_id: Operation.find(@request.operation_id).ration_id,
                                     requested_on: @request.requested_date,
                                     status: 'draft',
                                     requisition_items: @requisition_items
    })

    @requisition.created_by = current_user.id

    if(@requisition.save)
      @request.generated = true
      @request.save
      redirect_to "/requisitions/summary?region=#{@request.region_id}&operation=#{@request.operation_id}" , :flash => { notice: :success }
    else
      redirect_to RegionalRequest.find(params[:request_id]), :flash => { error: :unprocessable_entity }
    end
  end

  def summary

    @request = RegionalRequest.find_by({operation_id: params[:operation],
                                        region_id: params[:region]})

    @operation = Operation.find(@request.operation_id)

    @ration = Ration.find(@operation.ration_id)
    @commodities = []
    @ration.ration_items.each do |ration_item|
      @commodities << Commodity.find(ration_item.commodity_id)
    end
    @request_zones =  @request.regional_request_items.collect{|i| Fdp.find(i.fdp_id).location.ancestors.find { |a| a.location_type == 'zone' } }.uniq

    @requisitions = Requisition.where({request_id: @request.id})


    respond_to do |format|
      if @requisitions
        format.html { render :summary }
        format.json { render :summary, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @requisition.errors, status: :unprocessable_entity }
      end
    end
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_requisition
    @requisition = Requisition.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def requisition_params
    params.require(:requisition).permit(:requisition_no, :operation_id, :commodity_id, :region_id, :zone_id, :ration_id, :requested_by, :requested_on, :status)
  end

end
