class ContractReportsController < ApplicationController
    def index

    end

    def transport_order
         @request_id = params[:reference]
             puts  @rrd = Requisition.where(:'request_id' => @request_id).map{ |r| r.requisition_no}.uniq

        $transport_order_items = TransportOrderItem.joins(:fdp, transport_order: [:bid, :transporter, :operation, :location]).where(:'transport_orders.operation_id' => params[:operation],:'transport_order_items.requisition_no' => @rrd).select('transport_orders.id, operation_id, transport_orders.location_id as region_id, transporters.name as transporter, transport_order_items.fdp_id, 
        transport_order_items.unit_of_measure_id,
        transport_order_items.commodity_id as commodity_id, fdps.name, quantity, tariff, requisition_no,bids.bid_number')

        if $transport_order_items.present?
                $transport_order = TransportOrder.find($transport_order_items&.first&.id)
        end
        

        $transport_order_items = $transport_order_items.group_by(&:transporter)
        
       


    end
    
    def transport_order_pdf
        if !$transport_order_items.present?
            
             @request_id = params[:reference]
             puts  @rrd = Requisition.where(:'request_id' => @request_id).map{ |r| r.requisition_no}.uniq
            
             $transport_order_items = TransportOrderItem.joins(:fdp, transport_order: [:bid, :transporter, :operation, :location]).where(:'transport_orders.operation_id' => params[:operation],:'transport_order_items.requisition_no' => @rrd).select('transport_orders.id, operation_id, transport_orders.location_id as region_id,     transporters.name as transporter, transport_order_items.fdp_id, 
                transport_order_items.unit_of_measure_id,
                transport_order_items.commodity_id as commodity_id, fdps.name, quantity, tariff, requisition_no,bids.bid_number')

                 if $transport_order_items.present?
                    $transport_order = TransportOrder.find($transport_order_items&.first&.id)
                 end

                $transport_order_items = $transport_order_items.group_by(&:transporter)
             
               
        end
        
       
        respond_to do |format|
            format.html
            format.pdf do
          
            pdf = TransportOrderByTransporterPdf.new($transport_order_items, $transport_order)
            send_data pdf.render, filename: "transport_order_by_transporter_pdf.pdf",
            type: "application/pdf",
            disposition: "inline"
            end
        end

    end

    def transport_order_tariff_pdf
        if !$transport_order_items.present?
            
             @request_id = params[:reference]
             @rrd = Requisition.where(:'request_id' => @request_id).map{ |r| r.requisition_no}.uniq
             
             $transport_order_items = TransportOrderItem.joins(:fdp, transport_order: [:bid, :transporter, :operation, :location]).where(:'transport_orders.operation_id' => params[:operation],:'transport_order_items.requisition_no' => @rrd).select('transport_orders.id, operation_id, transport_orders.location_id as region_id,     transporters.name as transporter, transport_order_items.fdp_id, 
                transport_order_items.unit_of_measure_id,
                transport_order_items.commodity_id as commodity_id, fdps.name, quantity, tariff, requisition_no,bids.bid_number')

                if $transport_order_items.present?
                    $transport_order = TransportOrder.find($transport_order_items&.first&.id)
                end
               
                $transport_order_items = $transport_order_items.group_by(&:transporter)
                
               
        end
        
       
        respond_to do |format|
            format.html
            format.pdf do
          
            pdf = TransportOrderByTransporterWithTariffPdf.new($transport_order_items, $transport_order)
            send_data pdf.render, filename: "transport_order_by_transporter_pdf.pdf",
            type: "application/pdf",
            disposition: "inline"
            end
        end

    end

    def get_by_operation
    @bids = Bid.includes(:transport_orders).where( :'transport_orders.operation_id' => params[:operation_id] ).map{ |r| [r.bid_number, r.id, Location.find(r.region_id)&.name]} 
    respond_to do |format|
        format.json { render json:   @bids  }
        end
    end

    def rrd_reference_list
        @operation_id = params[:operation_id]
        @region_id = params[:region_id]

    
        @regional_request_references = RegionalRequest.includes(:requisitions).where(:'regional_requests.operation_id' => @operation_id, :'regional_requests.region_id' => @region_id).map{ |r| [r.reference_number, r.id]}  

        respond_to do |format|
            format.json {render json: @regional_request_references}
        end

  end

end
