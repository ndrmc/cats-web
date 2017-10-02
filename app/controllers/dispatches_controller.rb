class DispatchesController < ApplicationController
 before_action :authorize_dispatch

    def index
       
        if params[:find].present? 
            @dispatches = Dispatch.where gin_no: params[:gin_no]
            return
        end

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

    def new 
        if (params[:requisition_no].present?)
            @requisition = Requisition.includes(commodity: :commodity_category).where(:requisition_no => params[:requisition_no]).first
            @commodity = @requisition.commodity
            @category = @requisition.commodity.commodity_category
        end
        if (params[:fdp_id].present?)
            @woreda = Location.find(Fdp.find(params[:fdp_id]).location_id)
            @zone = @woreda.parent
            @region = @zone.parent
        end
        @dispatch = Dispatch.new
    end

    def create 
       

        dispatch_lines_hash = dispatch_params[:dispatch_items][0...-1]
        dispatch_items = dispatch_lines_hash.collect { |h| DispatchItem.new( h)}

        dispatch_map = dispatch_params.except(:dispatch_items)

        dispatch_map[:dispatch_items] = dispatch_items

        @dispatch = Dispatch.new( dispatch_map )
        @dispatch.created_by = current_user.id
        
        
        respond_to do |format|
            if @dispatch.save
                @woreda = Fdp.find(dispatch_params[:fdp_id].to_i).location
                @zone = Location.find(@woreda.parent_node_id)
                @region = Location.find(@zone.parent_node_id)
                format.html { redirect_to '/en/dispatches?hub=' + dispatch_params[:hub_id].to_s + '&operation=' + dispatch_params[:operation_id].to_s + '&region=' + @region.id.to_s + '&zone=' + @zone.id.to_s + '&woreda=' + @woreda.id.to_s + '&fdp=' + dispatch_params[:fdp_id].to_s, success: 'Dispatch was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

    def edit 
       
        @dispatch = Dispatch.find( params[:id])
        @woreda = Location.find(Fdp.find(@dispatch.fdp_id).location_id)
        @zone = Location.find(@woreda.parent_node_id)
        @region = Location.find(@zone.parent_node_id)
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

        if @dispatch.update( dispatch_map )
            respond_to do |format|
                @woreda = Fdp.find(dispatch_params[:fdp_id].to_i).location
                @zone = Location.find(@woreda.parent_node_id)
                @region = Location.find(@zone.parent_node_id)
                format.html { redirect_to '/en/dispatches?hub=' + dispatch_params[:hub_id].to_s + '&operation=' + dispatch_params[:operation_id].to_s + '&region=' + @region.id.to_s + '&zone=' + @zone.id.to_s + '&woreda=' + @woreda.id.to_s + '&fdp=' + dispatch_params[:fdp_id].to_s, success: 'Dispatch was successfully updated.' }
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
                :hub_id, :warehouse_id, 
                :fdp_id, 
                :weight_bridge_ticket_number, :transporter_id, 
                :plate_number, 
                :trailer_plate_number, 
                :storekeeper_name,
                :drivers_name, 
                :remark,
                :dispatch_items => [:id, :commodity_category_id, :commodity_id, :quantity,:unit_of_measure_id, :organization_id, :project_id]
            )
           
        end
end
