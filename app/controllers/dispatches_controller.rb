class DispatchesController < ApplicationController
 before_action :authorize_dispatch
    
 def index
       
        if (params[:operation].present? && params[:hub].present? && params[:region].present? && params[:zone].present? && params[:woreda].present? )
            if (params[:fdp].present?)
                @fdp_ids = params[:fdp]
            elsif (params[:woreda].present?)
                @fdp_ids = Fdp.where( location_id: params[:woreda]).map { |l| l.id}
            elsif (params[:zone].present?)
                fdp_locations = Location.find(params[:zone]).descendants.where( location_type: :woreda).map { |d| d.id}
                @fdp_ids = Fdp.where( location_id: fdp_locations).map { |l| l.id}
            end

            allocation_filter = { :'requisitions.operation_id' => params[:operation], :'requisition_items.fdp_id' => @fdp_ids }

            requisitions = Requisition.joins(:requisition_items).where( allocation_filter ).pluck(:requisition_no).to_a

            dispatch_filter = {:'dispatches.hub_id' => params[:hub], :'dispatches.operation_id' => params[:operation], :'dispatches.fdp_id' => @fdp_ids, :'dispatches.requisition_number' => requisitions }  
            
            gin_filter = {:'dispatches.hub_id' => params[:hub], :'dispatches.operation_id' => params[:operation], :'dispatches.fdp_id' => @fdp_ids }

            @dispatch_summary = Dispatch.fdp_allocations(params[:hub], params[:operation], allocation_filter, @fdp_ids)                       

            @dispatches = Dispatch.fdp_dispatches(dispatch_filter)           
            
        else 
            @dispatch_summary = []
            @dispatches = []
        end 
        return @dispatches
    end

    def dispatch_report_generate
         filter_map = {}
      if params[:hub].present?
        filter_map = {hub_id: params[:hub]}

      if params[:dispatch_date ].present?
        dates = params[:dispatch_date].split(' - ').map { |d| Date.parse d }
        filter_map[:dispatched_date] = dates[0]..dates[1]
      end
            @dispatch = DispatchItem.includes(:commodity,:project,:unit_of_measure, { dispatch: [ { fdp: [:location] } ,:transporter, :operation] })
            .where(:'dispatches.hub_id' => params[:hub]).where("dispatches.dispatch_date >= ? AND dispatches.dispatch_date <= ? ",dates[0],dates[1])
        
      else
         @dispatch = []
      end

    hub = Hub.find(params[:hub])
    respond_to do |format|
            format.html
            format.pdf do
            pdf = DispatchPdf.new(@dispatch,dates[0],dates[1],hub.name)
            send_data pdf.render, filename: "dispatch_report.pdf",
            type: "application/pdf",
            disposition: "inline"
            end
        end

    end

    def validate_quantity    
        @hub_id = dispatch_params["hub_id"]
        @warehouse_id = dispatch_params["warehouse_id"]
        @project_id = dispatch_params["proj_id"]
        @quantity = dispatch_params["quantity"]
        @unit = dispatch_params["unit"]
        @requisition_no = dispatch_params["requisition_number"]
       

        @requisition = Requisition.where(:requisition_no => @requisition_no).first
        @project_code_allocation = ProjectCodeAllocation.where(:requisition_id => @requisition.id, :project_id => @project_id).first
        @allocated = 0
        if ( @project_code_allocation.present? )
            target_unit = UnitOfMeasure.find_by(code: "MT")
            current_unit = UnitOfMeasure.find(@project_code_allocation.unit_of_measure_id)
            @allocated = target_unit.convert_to(current_unit.name, @project_code_allocation.amount)
        end

        stock_account = Account.find_by({'code': :stock})
        @stock = PostingItem.where(account_id: stock_account.id, hub_id: @hub_id, warehouse_id: @warehouse_id, project_id: @project_id).sum(:quantity)
        quantity_in_ref = UnitOfMeasure.find(@unit.to_i).to_ref(@quantity.to_f)
        @stock += @allocated
        @flag = false
        if(quantity_in_ref < @stock)
            @flag = true
        end
        respond_to do |format|
            format.html
            format.json { render :json => @flag.to_json }
        end
    end

    def check_stock    
        @hub_id = dispatch_params["hub_id"]
        @warehouse_id = dispatch_params["warehouse_id"]
        @project_id = dispatch_params["proj_id"]
        @requisition_no = dispatch_params["requisition_number"]
        @requisition = Requisition.where(:requisition_no => @requisition_no).first
        @project_code_allocation = ProjectCodeAllocation.where(:requisition_id => @requisition.id, :project_id => @project_id).first
        @allocated = 0
        if ( @project_code_allocation.present? )
            @allocated = UnitOfMeasure.find(@project_code_allocation.unit_of_measure_id).to_ref(@project_code_allocation.amount)
        end
        
        stock_account = Account.find_by({'code': :stock})
        @stock = PostingItem.where(account_id: stock_account.id, hub_id: @hub_id, warehouse_id: @warehouse_id, project_id: @project_id).sum(:quantity)
        @stock = @stock + @allocated
        respond_to do |format|
            format.html
            format.json { render :json => @stock.to_json }
        end
    end

    def get_hub_warehouse    
        @fdp_id = dispatch_params["fdp_id"]
        @requisition_no = dispatch_params["requisition_number"]
        @requisition = Requisition.where(:requisition_no => @requisition_no).first
        @data = []
        ProjectCodeAllocation.includes(:hub, :warehouse, :store, project: :organization).where(:requisition_id => @requisition.id).each do |pca|
            @data << { 'hub_id' => pca&.hub_id, 'hub' => pca&.hub&.name, 'warehouse_id' => pca&.warehouse_id, 'warehouse' => pca&.warehouse&.name, 'store_id' => pca&.store_id, 'store' => pca&.store&.name, 'project_id' => pca&.project_id, 'project' => pca&.project&.project_code, 'donor_id' => pca&.project&.organization_id, 'donor' => pca&.project&.organization&.name }        
        end

        if (@data.empty?)
            WarehouseAllocationItem.includes(:hub, :warehouse).where(:requisition_id => @requisition.id, :fdp_id => @fdp_id).each do |wai|
                @data << { 'hub_id' => wai&.hub_id, 'hub' => wai&.hub&.name, 'warehouse_id' => wai&.warehouse_id, 'warehouse' => wai&.warehouse&.name, 'store_id' => '', 'store' => '', 'project_id' => '', 'project' => '', 'donor_id' => '', 'donor' => '' }        
            end
        end

        if (@data.empty?)
            @zone = Fdp.includes(:location).find(@fdp_id).location.parent
            if(@zone.warehouse_id.present?)
                @warehouse = Warehouse.includes(:hub).find(@zone.warehouse_id)
                @data << { 'hub_id' => @warehouse&.hub_id, 'hub' => @warehouse&.hub&.name, 'warehouse_id' => @warehouse&.id, 'warehouse' => @warehouse&.name, 'store_id' => '', 'store' => '', 'project_id' => '', 'project' => '', 'donor_id' => '', 'donor' => '' }
            end
        end

        respond_to do |format|
            format.html
            format.json { render :json => @data.to_json }
        end
    end
    

    def dispatch_report_items
            filter_map = {}
      if params[:hub].present?
        filter_map = {'dispatches.hub_id': params[:hub]}
        @hub = Hub.find(params[:hub])&.name
      if params[:dispatch_date ].present?
        dates = params[:dispatch_date].split(' - ').map { |d| Date.parse d }
         @date_min = dates[0]
         @date_max = dates[1]
        filter_map[:'dispatches.dispatch_date'] = dates[0]..dates[1]
      end
            @dispatch_items = DispatchItem.joins(:commodity,:project,:unit_of_measure, { dispatch: [ { fdp: [:location] } ,:transporter, :operation] })
            .where(filter_map).select('dispatches.dispatch_date,dispatches.requisition_number,dispatches.operation_id, dispatches.fdp_id as fdp_id,dispatches.gin_no, dispatches.transporter_id, dispatches.plate_number, dispatches.trailer_plate_number, dispatch_items.project_id,dispatch_items.commodity_category_id, dispatch_items.commodity_id, dispatch_items.quantity, dispatch_items.unit_of_measure_id,dispatches.storekeeper_name, dispatches.store_id')
        
      else
         @dispatch_items = []
      end

    
    end

    def dispatch_report
             filter_map = {}
      if params[:hub].present?
        filter_map = {hub_id: params[:hub]}
        hub = Hub.find(params[:hub])
      if params[:dispatch_date ].present?
        dates = params[:dispatch_date].split(' - ').map { |d| Date.parse d }
        filter_map[:dispatch_date] = dates[0]..dates[1]
      end
            @dispatch = DispatchItem.includes(:commodity,:project,:unit_of_measure, { dispatch: [ { fdp: [:location] } ,:transporter, :operation] })
            .where(:'dispatches.hub_id' => params[:hub]).where("dispatches.dispatch_date >= ? AND dispatches.dispatch_date <= ? ",dates[0],dates[1])
            @date_min = dates[0]
            @date_max = dates[1]
            @hub = hub.name
        
      else
         @dispatch = []
      end


    end
    
    def basic
        @dispatches = []
        if params[:find].present? 
            @dispatches = Dispatch.where gin_no: params[:gin_no]
            return
        end
    end

    def new 
        if (params[:requisition_no].present?)
            @requisition = Requisition.includes(commodity: :commodity_category).where(:requisition_no => params[:requisition_no]).first
            @commodity = @requisition.commodity
            @category = @requisition.commodity.commodity_category
        end
        if (params[:fdp_id].present?)
            @woreda = Location.find(Fdp.find(params[:fdp_id]).location_id)
            @zone = @woreda&.parent
            @region = @zone&.parent
        end
        @dispatch = Dispatch.new
        @stores = Store.order(:name)
    end

    def create 
       

        dispatch_lines_hash = dispatch_params[:dispatch_items][0...-1]
        dispatch_items = dispatch_lines_hash.collect { |h| DispatchItem.new( h)}

        dispatch_map = dispatch_params.except(:dispatch_items)

        dispatch_map[:dispatch_items] = dispatch_items

        @dispatch = Dispatch.new( dispatch_map )
        @dispatch.created_by = current_user.id
        
        @path = ''
        if(params[:basic].present?)
            @path = '/en/dispatches/basic?utf8=✓&gin_no=' + @dispatch.gin_no.to_s + '&find=Go'
        else
            @woreda = Fdp.find(dispatch_params[:fdp_id].to_i).location
            @zone = @woreda&.parent
            @region = @zone&.parent
            @path = '/en/dispatches?hub=' + dispatch_params[:hub_id].to_s + '&operation=' + dispatch_params[:operation_id].to_s + '&region=' + @region.id.to_s + '&zone=' + @zone.id.to_s + '&woreda=' + @woreda.id.to_s + '&fdp=' + dispatch_params[:fdp_id].to_s
        end

        respond_to do |format|
            if @dispatch.save
                @woreda = Fdp.find(dispatch_params[:fdp_id].to_i).location
                @zone = @woreda&.parent
                @region = @zone&.parent
                format.html { redirect_to '/en/dispatches?hub=' + dispatch_params[:hub_id].to_s + '&operation=' + dispatch_params[:operation_id].to_s + '&region=' + @region&.id.to_s + '&zone=' + @zone&.id.to_s + '&woreda=' + @woreda&.id.to_s + '&fdp=' + dispatch_params[:fdp_id].to_s, success: 'Dispatch was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

    def edit 
       
        @dispatch = Dispatch.find( params[:id])
        if (@dispatch.fdp_id.present?)
            @fdp = Fdp.find(@dispatch.fdp_id)
            if (@fdp.present?)
                @woreda = Location.find(@fdp.location_id)
                @zone = @woreda&.parent
                @region = @zone&.parent
            end
        end
    end

    def update   

        @dispatch = Dispatch.find(params[:id])

        @dispatch.modified_by = current_user.id

        dispatch_line_ids = @dispatch.dispatch_items.collect { |rl| rl.id }

        recept_lines_hash = dispatch_params[:dispatch_items][0...-1]
       
        deleted_dispatch_line_ids = dispatch_line_ids -  recept_lines_hash.collect { |r| r[:id].to_i }

        DispatchItem.where( :id => deleted_dispatch_line_ids).destroy_all 

        dispatch_items = recept_lines_hash.collect do |h| 
                            if h[:id] != nil
                                DispatchItem.find(h[:id])
                            else             
                                DispatchItem.new( h)
                            end
                         end

        dispatch_map = dispatch_params.except(:dispatch_items)

        dispatch_map[:dispatch_items] = dispatch_items
        
        @path = ''
        if(params[:basic].present?)
            @path = '/en/dispatches/basic?utf8=✓&gin_no=' + @dispatch.gin_no.to_s + '&find=Go'
        else
            @woreda = Fdp.find(dispatch_params[:fdp_id].to_i).location
            @zone = Location.find(@woreda.parent_node_id)
            @region = Location.find(@zone.parent_node_id)
            @path = '/en/dispatches?hub=' + dispatch_params[:hub_id].to_s + '&operation=' + dispatch_params[:operation_id].to_s + '&region=' + @region.id.to_s + '&zone=' + @zone.id.to_s + '&woreda=' + @woreda.id.to_s + '&fdp=' + dispatch_params[:fdp_id].to_s
        end

        if @dispatch.update( dispatch_map )
            respond_to do |format|
                @woreda = Fdp.find(dispatch_params[:fdp_id].to_i).location
                @zone = @woreda&.parent
                @region = @zone&.parent
                format.html { redirect_to '/en/dispatches?hub=' + dispatch_params[:hub_id].to_s + '&operation=' + dispatch_params[:operation_id].to_s + '&region=' + @region&.id.to_s + '&zone=' + @zone&.id.to_s + '&woreda=' + @woreda&.id.to_s + '&fdp=' + dispatch_params[:fdp_id].to_s, success: 'Dispatch was successfully updated.' }
            end
        else
            respond_to do |format|
                format.html { render :edit }
            end
        end
    end


    private 
    def authorize_dispatch
        authorize Dispatch
    end

        def dispatch_params
            params.require(:dispatch).permit( 
                :gin_no, :requisition_number,
                :operation_id, :dispatch_date, 
                :hub_id, :warehouse_id, :proj_id, :quantity, :unit,
                :fdp_id, 
                :weight_bridge_ticket_number, :transporter_id, 
                :plate_number, 
                :trailer_plate_number, 
                :storekeeper_name,
                :store_id,
                :drivers_name, 
                :remark,
                :dispatch_items => [:id, :commodity_category_id, :commodity_id, :quantity,:unit_of_measure_id, :organization_id, :project_id]
            )
           
        end
end
