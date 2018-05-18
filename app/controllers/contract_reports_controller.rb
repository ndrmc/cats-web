class ContractReportsController < ApplicationController
    def index

    end

    def transport_order
        @transport_order_items = TransportOrderItem.joins(:fdp, transport_order: [:bid, :transporter, :operation, :location]).where(:'transport_orders.operation_id' => params[:operation],:'transport_orders.bid_id' => params[:bid]).select('transport_orders.id, operation_id, transport_orders.location_id as region_id, transporters.name as transporter, transport_order_items.fdp_id, 
        transport_order_items.unit_of_measure_id,
        transport_order_items.commodity_id as commodity_id, fdps.name, quantity, tariff, requisition_no,bids.bid_number')

        

        @transport_order_items = @transport_order_items.group_by(&:transporter)
        
        @transport_order = TransportOrder.where(:operation_id => params[:operation],:bid_id => params[:bid]).first


    end
    
    def get_by_operation
    @bids = Bid.includes(:transport_orders).where( :'transport_orders.operation_id' => params[:operation_id] ).map{ |r| [r.bid_number, r.id]} 
    respond_to do |format|
        format.json { render json:   @bids  }
        end
    end


end
