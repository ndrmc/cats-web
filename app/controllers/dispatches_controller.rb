class DispatchesController < ApplicationController

    def index
        @dispatches = Dispatch.all
    end

    def new 
        @dispatch = Dispatch.new
    end

    def create 
        dispatch_lines_hash = dispatch_params[:dispatch_items][0...-1]
        dispatch_lines = dispatch_lines_hash.collect { |h| DispatchItem.new( h)}

        dispatch_map = dispatch_params.except(:dispatch_items)

        dispatch_map[:dispatch_items] = dispatch_lines

        @dispatch = Dispatch.new( dispatch_map )

        respond_to do |format|
            if @dispatch.save
                format.html { redirect_to dispatchs_path, success: 'Receipt was successfully created.' }
            else
                format.html { render :new }
            end
        end
    end

    def edit 
        @dispatch = Dispatch.find( params[:id])
    end


    private 
        def dispatch_params
            params.require(:dispatch).permit( 
                :gin_no, :operation_id, :dispatch_date, 
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
