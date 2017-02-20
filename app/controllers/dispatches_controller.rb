class DispatchesController < ApplicationController

    def index
        if params[:find].present? 
            @dispatches = Dispatch.where gin_no: params[:gin_no]
            return
        end
        

        if params[:operation].present? && params[:hub].present? && params[:region].present?
            filter_map = {hub_id: params[:hub], operation_id: params[:operation]}
            
            if params[:dispatch_date ].present? 
                dates = params[:dispatch_date].split(' - ').map { |d| Date.parse d }

                filter_map[:dispatch_date] = dates[0]..dates[1]
            end

            if params[:status ]
                filter_map[:draft ] = params[:status ] == 'Draft'
            end

            region = Location.find params[:region]

            fdp_locations = region.descendants.map { |d| d.id}.push params[:region] 

            fdp_ids = Fdp.where( location_id: fdp_locations).map { |l| l.id}

            filter_map[:fdp_id] = fdp_ids

            @dispatches = Dispatch.joins( :dispatch_items ).where( filter_map ).distinct
        else 
           
            @dispatches = []
        end 
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
        def dispatch_params
            params.require(:dispatch).permit( 
                :gin_no, :requisition_number,
                :operation_id, :dispatch_date, 
                :hub_id, :warehouse_id, 
                :fdp_id, 
                :weight_bridge_ticket_number, :transporter_id, 
                :plate_number, 
                :trailer_plate_number, 
                :drivers_name, 
                :remark,
                :dispatch_items => [:id, :commodity_category_id, :commodity_id, :quantity, :project_id]
            )
           
        end
end
