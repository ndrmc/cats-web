class TransportRequisitionsController < ApplicationController  
  before_action :set_transport_requisition, only: [:edit, :update, :destroy]
 include ReferenceHelper
  # GET /transport_requisitions
  # GET /transport_requisitions.json
  def index
    if (params[:operation_id].to_s == '' || params[:operation_id].to_s == nil)
      @operation_id = Operation.all.order(:name).first.id
    else
      @operation_id = params[:operation_id]
    end
    @transport_requisitions = TransportRequisition.joins('INNER JOIN transport_requisition_items ON transport_requisitions.id = transport_requisition_items.transport_requisition_id INNER JOIN locations ON locations.id = transport_requisitions.location_id').select('transport_requisitions.id, transport_requisitions.operation_id, transport_requisitions.reference_number, transport_requisitions.reference_number, transport_requisitions.location_id, locations.name AS region_name, transport_requisitions.created_at, transport_requisitions.status, sum(transport_requisition_items.quantity) as total_qty, count(transport_requisition_items.id) as destinations').where('transport_requisitions.operation_id = ' + @operation_id.to_s).group('transport_requisitions.id, transport_requisitions.operation_id, transport_requisitions.reference_number, transport_requisitions.reference_number, transport_requisitions.location_id, locations.name, transport_requisitions.created_at, transport_requisitions.status').order('created_at DESC')
  end

  def print
    
    # @transport_requisition_items = TransportRequisitionItem.joins(:commodity, :requisition, fdp: :location).group('locations.parent_node_id, commodities.id, commodities.name, requisitions.id, requisitions.requisition_no').select('transport_requisition_items.id, commodities.name AS commodity_name, requisitions.requisition_no, SUM(quantity) AS zone_allocated')
    
    
     
    # @transport_requisition_items = tzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzri_full_list.group_by(&:zone_id).map{ |zone_id,tri_full_list| {:zone_id => zone_id.to_i, :zone_allocated => tri_full_list.sum {|j| j.quantity.to_f} }}
    # @transport_requisition_items = tri_full_list.group_by { |h| h[:zone_id] }.values
    # .map do |a,b,c,d,e,f,g,h,i,j,k,l,m,n|       
    #   {:tri_id => a.to_s,:commodity_id => b.to_s,:commodity_name => c.to_s,:requisition_id => d.to_s,:requisition_no => e.to_s,:quantity => f.map {|h1| h1[:quantity]}.inject(:+),:zone_id => k.to_s,:zone_name => l.to_s,:region_id => m.to_s,:region_name => n.to_s} 
    # end

    # hsh = tri_full_list.group_by { |h| h[:requisition_id] }.map do |b,c,d,e,f,k,l,m| 
    #   {:commodity_id => b.to_s,:commodity_name => c.to_s,:requisition_id => d.to_s,:requisition_no => e.to_s,:quantity => f.map {|h1| h1[:quantity]}.inject(:+),:zone_id => k.to_s,:zone_name => l.to_s,:region_id => m.to_s,:region_name => n.to_s}
    # end

    @transport_requisition = TransportRequisition.find(params[:id])
    @transport_requsition_items =  @transport_requisition.transport_requisition_items
    @requisition_ids = @transport_requsition_items.map{|r|r.requisition_id }.uniq
    @reference_numbers = get_reference_numbers_by_requisition_id(@requisition_ids)
    project = []
    @transport_requsition_items.each do |item |
       project_id = ProjectCodeAllocation.where(requisition_id: item.requisition_id,fdp_id: item.fdp_id).pluck(:project_id)

    if project_id.present?
       project_code = Project.find(project_id[0]).project_code
       temp = { Commodity.find(item.commodity_id).name => project_code }
       if !project.include?(temp)
          project << temp
       end
end
    end
  
    respond_to do |format|
      format.html
      format.pdf do
          pdf = TransportRequisitionPdf.new(params[:id], params[:reason_for_idps], params[:cc_letter_to], @reference_numbers,project)
          send_data pdf.render, filename: "trasnport_requisition_#{@transport_requisition.id}.pdf",
          type: "application/pdf",
          disposition: "inline"
      end      
    end
  end

  # GET /transport_requisitions/1
  # GET /transport_requisitions/1.json
  def show   

    @woredas_wo_winner = TransportRequisitionItem.joins('INNER JOIN transport_requisitions ON transport_requisitions.id = transport_requisition_items.transport_requisition_id INNER JOIN fdps ON fdps.id = transport_requisition_items.fdp_id INNER JOIN locations AS woreda ON woreda.id = fdps.location_id INNER JOIN locations AS zone ON zone.id = woreda.parent_node_id').where('transport_requisition_items.transport_requisition_id = ' + params[:id] + ' AND transport_requisition_items.has_transport_order = false').group('woreda.id, woreda.name, zone.id, zone.name').select('SUM(transport_requisition_items.quantity) AS total_qty, woreda.id AS woreda_id, woreda.name AS woreda_name, zone.id AS zone_id, zone.name AS zone_name').to_a

    @transport_orders = TransportOrder.includes(:transporter, :bid, :contract, transport_order_items: [transport_requisition_item: :transport_requisition]).where(:'transport_requisition_items.transport_requisition_id' => params[:id])
    @transport_requisition = TransportRequisition.includes(operation: :program, transport_requisition_items: [:commodity, fdp: :location, transport_order_items: [transport_order: :transporter], requisition: [:region, :zone] ]).find(params[:id])
    @tri_aggregate_by_zone = TransportRequisitionItem.includes(:commodity, fdp: :location, requisition: [:region, :zone]).where(:transport_requisition_id => params[:id]).group(:requisition_id, :'requisitions.requisition_no', :'commodities.name', :'regions_requisitions.name', :'zones_requisitions.name').sum(:quantity)
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

    @bid_id = transport_requisition_params['bid_id']
    @request_ids = transport_requisition_params['request_id']
    @result = false
    result = TransportRequisition.generate_tr(transport_requisition_params, current_user.id,@request_ids)
    if (result.present?)
      @result = TransportOrder.generate_transport_order(result.id, @bid_id, current_user.id)
    end
    respond_to do |format|
      if @result
        format.html { redirect_to transport_requisitions_url('en',result), notice: 'Transport requisition was successfully created.' }
        format.json { render json: { :successful => true }}
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

  def get_fdps_list
    @fdps = TransportRequisitionItem.joins(fdp: :location).where(:transport_requisition_id => params[:id], :'locations.id' => params[:location_id], :has_transport_order => false).select(:'fdps.id AS id', :'fdps.name AS name')
    respond_to do |format|
      format.html { redirect_to transport_requisitions_url('en'), notice: 'Transport requisition was successfully destroyed.' }
      format.json { render json: @fdps, status: :ok  }
    end
  end

  def create_to_for_exceptions
    @result = TransportOrder.to_for_exception(transport_requisition_params[:tr_id], transport_requisition_params[:location_id], transport_requisition_params[:transporter_id], transport_requisition_params[:tariff], current_user.id)

    respond_to do |format|
      if @result
        format.html { redirect_to transport_requisitions_url('en',@result), notice: 'Transport order was successfully created.' }
        format.json { render json: @result, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: 'Create transport order for exception transport requisitions failed!', status: :unprocessable_entity }
      end
    end
  end

  def rrd_reference_list
    @operation_id = params[:operation_id]
    @region_id = params[:region_id]

  
    @regional_request_references = RegionalRequest.includes(:requisitions).where(:'regional_requests.operation_id' => @operation_id, :'regional_requests.region_id' => @region_id,:'requisitions.status' => Requisition.statuses[:approved]).all 

    respond_to do |format|
     format.js
     format.html
    end

  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transport_requisition
      @transport_requisition = TransportRequisition.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def transport_requisition_params
      params.require(:transport_requisition).permit(:reference_number, :location_id, :operation_id, :certified_by, :certified_date, :description, :status, :deleted_by, :deleted_at, :bid_id, :tr_id, :transporter_id, :tariff, request_id: [])
    end
end
