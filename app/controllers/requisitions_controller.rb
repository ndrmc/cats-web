class RequisitionsController < ApplicationController
  before_action :set_requisition, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :authorize_requisition, except: [:show]
  include ReferenceHelper
  # GET /requisitions
  # GET /requisitions.json
  def index
    if(params[:operation].present? && params[:region].present?)
      @requisitions = Requisition.filter(params.slice(:operation, :region, :status))
    else
      @requisitions = []
    end
  end

  def print
    @requisition_items = RequisitionItem.includes(:fdp, requisition: [:commodity, ration: :ration_items, operation: :program]).where(:'requisitions.id' => params[:id]).where("beneficiary_no > 0")
    @total_beneficiary_no = RequisitionItem.where(:requisition_id => params[:id]).where("beneficiary_no > 0").sum(:beneficiary_no)
   
    @references = get_reference_numbers_by_requisition_no(Requisition.find(params[:id]).requisition_no)
    
    @total_amount = RequisitionItem.where(:requisition_id => params[:id]).where("beneficiary_no > 0").sum(:amount)
   
    respond_to do |format|
      format.html
      format.pdf do
          pdf = RequisitionPdf.new(@requisition_items, @total_beneficiary_no, @total_amount,  @references)
          send_data pdf.render, filename: "requisition_#{@requisition_items.first.requisition.id}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end      
    end
  end

  def print_rrd
   
     @requisition = Requisition.joins('INNER JOIN requisition_items ON requisition_items.requisition_id = requisitions.id').
     group('requisition_no, requisitions.id,zone_id,region_id, zone_id,operation_id,ration_id,commodity_id')
     .select('requisition_no, commodity_id,requisitions.id as requisition_id, sum(requisition_items.amount) as total_allocated, region_id, zone_id,operation_id,
     ration_id').where('requisitions.id=' + params[:id])

     @current_user = current_user.name
     respond_to do |format|
      format.html
      format.pdf do
          pdf = RequisitionInvoicePdf.new(@requisition,@current_user)
          send_data pdf.render, filename: "RequisitionInvoicePdf_#{@requisition.first.requisition_id}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end      
    end
  end 
  

  # GET /requisitions/new
  def new
    @requisition = Requisition.new
  end

  # GET /requisitions/1/edit
  def edit
    @contingency = RequisitionItem.where(requisition_id: params[:id]).sum(:contingency)
    @amount = RequisitionItem.where(requisition_id: params[:id]).sum(:amount)
    @commodity_list = Commodity.where(commodity_category_id: @requisition.commodity.commodity_category.id).order(:name)
    @dispatch_count = Dispatch.where(requisition_number: @requisition.requisition_no).count
  end



  # PATCH/PUT /requisitions/1
  # PATCH/PUT /requisitions/1.json
  def update
    requisition = Requisition.find_by_requisition_no requisition_params[:requisition_no]
    if requisition.present?
     if @requisition.update(update_requisition_params)
        respond_to do |format|
        format.html { redirect_to edit_requisition_path(@requisition), notice: 'Requisition number exisits but the other parameters were successfully updated.' }
        format.json { render :edit, status: :ok, location: @requisition }
        end
      end
    else
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
    requisition = Requisition.includes(commodity: :commodity_category).find_by_requisition_no params[:requisition_no]
    if requisition.present?
      category = CommodityCategory.find(Commodity.find(requisition.commodity_id).commodity_category_id)
    end
    respond_to do |format|
      if requisition.present?
        format.json { render json: { requisition: requisition, commodity_category_id:  category.id}}
      else
        format.json { render json: { }}
      end
    end
  end

  # PREPARE /requisitions/prepare?request_id=1
  def prepare
    @request = RegionalRequest.find(params[:request_id])
    @zero_beneficiary_nos = @request.regional_request_items.where('number_of_beneficiaries < 1')
    if (@zero_beneficiary_nos.present?)
       respond_to do |format|
            flash[:error] = "Can not create requisition as there are zones with zero beneficiary number."
            format.html {  redirect_to request.referrer }
      end
    end
    
    @requests_per_zone = @request.regional_request_items.group_by { |ri| Fdp.find(ri.fdp_id).location.ancestors.find { |a| a.location_type == 'zone' } }
    @operation = Operation.find(@request.operation_id)

    @ration = Ration.find(@operation.ration_id)
    @commodities = []
    @ration.ration_items.each do |ration_item|
      @commodities << Commodity.find(ration_item.commodity_id)
    end
  end

 def delete_regional_requests_fdps_with_zero_ben_no
    @request = RegionalRequest.find(params[:id])
    @zero_beneficiary_nos = @request.regional_request_items.where('number_of_beneficiaries < 1')
    if (@zero_beneficiary_nos.delete_all)
      respond_to do |format|
            flash[:notice] = "FDPs with zero beneficiary numbers have been deleted."
            format.html {  redirect_to request.referrer }
      end
    else
        respond_to do |format|
            flash[:alert] = "Operation was unsuccessful."
            format.html {  redirect_to request.referrer }
      end
    end
    
 end

def contingency
  psnp_contingency = 0.05
  flag = 0
  @requisition = Requisition.find_by(id: params[:request_id])
  if params[:type] == 'generate'
  @requisition.requisition_items.each do |item|
    item.contingency = item.amount * psnp_contingency
    item.transaction do
    item.save
    flag = 1
      end
  end
else
  psnp_contingency = 0
  @requisition.requisition_items.each do |item|
    item.contingency = item.amount * psnp_contingency
    item.transaction do
    item.save
    flag = 1
      end
  end
end

  if flag 
   respond_to do |format|
            flash[:notice] = "contingency has been created for this requsition."
            format.html {  redirect_to request.referrer }
      end
  else
      respond_to do |format|
            flash[:alert] = "contingency has not been created for this requsition."
            format.html {  redirect_to request.referrer }
      end
  end

end

  def generate
    psnp_contingency = 0.05
    
    if params[:contingency] == "0"
      psnp_contingency = 0
    end
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

            amount =  @ration_items.select { |hash| hash[:commodity_id] == Integer(commodity_id) }.first.amount*request_item[:number_of_beneficiaries]

            requisition_item = RequisitionItem.new({
                                                     fdp_id: request_item[:fdp_id],
                                                     beneficiary_no: request_item[:number_of_beneficiaries],
                                                     amount: amount,
                                                     contingency: amount * psnp_contingency
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
      render :js => "window.location = '/requisitions/summary/#{@request.id}' ,
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

    @request = RegionalRequest.find(params[:request_id])

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

  def export_requisition_to_excel
    @request_allocations = []
    @request = RegionalRequest.find(params[:id])
    @requisitions = RequisitionItem.includes( requisition: :commodity, fdp: :location).where({:'requisitions.request_id' => params[:id]}).where('beneficiary_no > 0').each do |ri|
      @requisition = Requisition.includes(ration: :ration_items).find(ri.requisition_id) 
      @uom_id = @requisition.ration.ration_items.where(commodity_id: @requisition.commodity_id).first.unit_of_measure_id
      target_unit = UnitOfMeasure.find_by(name: "Quintal")
      current_unit = UnitOfMeasure.find(@uom_id)
      quantity_in_ref = target_unit.convert_to(current_unit.name, ri.amount.to_f)

      @request_allocations << { region: ri.fdp.location.parent.parent.name, zone: ri.fdp.location.parent.name, woreda: ri.fdp.location.name, fdp: ri.fdp.name, requisition_no: ri.requisition.requisition_no, beneficiary_no: ri.beneficiary_no, commodity: ri.requisition.commodity.name, amount: quantity_in_ref }
    end
  end

  private
  def authorize_requisition
    authorize Requisition
  end
  
  # Use callbacks to share common setup or constraints between actions.
  def set_requisition
    @requisition = Requisition.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def requisition_params
    params.require(:requisition).permit(:requisition_no, :operation_id, :commodity_id, :region_id, :zone_id, :ration_id, :requested_by, :requested_on, :status, :contingency)
  end

  def update_requisition_params
    params.require(:requisition).permit(:operation_id, :commodity_id, :region_id, :zone_id, :ration_id, :requested_by, :requested_on, :status)
  end

end
