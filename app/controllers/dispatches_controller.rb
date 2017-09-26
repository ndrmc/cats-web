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
            else
                fdp_locations = Location.find(params[:region]).descendants.where( location_type: :woreda).map { |d| d.id}
                @fdp_ids = 18            
            end

            allocation_filter = { :'requisitions.operation_id' => params[:operation], :'requisition_items.fdp_id' => @fdp_ids }

            requisitions = Requisition.joins(:requisition_items).where( allocation_filter ).pluck(:requisition_no).to_a

            dispatch_filter = {:'dispatches.hub_id' => params[:hub], :'dispatches.operation_id' => params[:operation], :'dispatches.fdp_id' => @fdp_ids, :'dispatches.requisition_number' => requisitions }  
            
            gin_filter = {:'dispatches.hub_id' => params[:hub], :'dispatches.operation_id' => params[:operation], :'dispatches.fdp_id' => @fdp_ids }

            @dispatch_summary = []
            
            Requisition.joins(:requisition_items, :commodity).where( allocation_filter ).where(' requisition_items.amount > 0').uniq{|t| t.requisition_no }.each do |allocation|
                @row = Hash.new
                @row['requisition_no'] = allocation.requisition_no
                @row['commodity'] = allocation.commodity.name
                @total_allocated = 0
                allocation.requisition_items.where(:fdp_id => @fdp_ids).each do |ri|
                    uom_id = allocation&.operation&.ration&.ration_items.where(commodity_id: allocation.commodity_id)&.first&.unit_of_measure_id
                    if(uom_id.present?)
                        @total_allocated = @total_allocated + UnitOfMeasure.find(uom_id).to_ref(ri.amount)
                    else
                        @total_allocated = @total_allocated + ri.amount
                    end
                end
                @row['allocated'] = @total_allocated
                # dispatch_filter[:requisition_number] = allocation.requisition_no
                @total_dispatched = 0
                Dispatch.joins(:dispatch_items).where( {:'dispatches.hub_id' => params[:hub], :'dispatches.operation_id' => params[:operation], :'dispatches.fdp_id' => @fdp_ids, :'dispatches.requisition_number' => allocation.requisition_no } ).select(:id, :'dispatch_items.quantity', :'dispatch_items.unit_of_measure_id').find_each do |di|                    
                    @qty_in_ref = UnitOfMeasure.find(di.unit_of_measure_id).to_ref(di.quantity)
                    @total_dispatched = @total_dispatched + @qty_in_ref
                end
                @row['dispatched'] = @total_dispatched
                @row['progress'] = (@total_dispatched.to_f / @total_allocated.to_f) * 100
                @dispatch_summary << @row
            end

            @dispatches = []
            Dispatch.joins( :transporter, dispatch_items: [:unit_of_measure, :commodity] ).where( dispatch_filter ).find_each do |dispatch|
                @gin_row = Hash.new
                @gin_row['gin_no'] = dispatch.gin_no
                @gin_qty = 0
                dispatch.dispatch_items.find_each do |di|
                    @qty_in_ref = UnitOfMeasure.find(di.unit_of_measure_id).to_ref(di.quantity)
                    @gin_qty = @gin_qty + @qty_in_ref
                    @gin_row['commodity'] = di.commodity.name
                end
                @gin_row['dispatch_qty'] = @gin_qty
                @gin_row['uom'] = 'MT'
                @gin_row['transporter'] = dispatch.transporter.name
                @gin_row['dispatch_date'] = dispatch.dispatch_date
                @dispatches << @gin_row
            end
            
        else 
            @dispatch_summary = []
            @dispatches = []
        end 
        return @dispatches
    end

    def new 
       
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
                format.html { redirect_to dispatches_path, success: 'Dispatch was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

    def edit 
       
        @dispatch = Dispatch.find( params[:id])
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
                format.html { redirect_to dispatches_path, notice: 'Dispatch was successfully updated.' }
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
