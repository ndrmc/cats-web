module BidsHelper
	def generate_bid_winners (id)
        @current_rank = 1
        @current_tariff = -1
        @current_location_id = -1
        @current_warehouse_id = -1
        @result = false


        i = 0
        record_count = BidQuotation.joins(:bid_quotation_details).where(:bid_id => params[:id]).count
        records = BidQuotation.joins(:bid_quotation_details).where(:bid_id => params[:id]).select(:id, 'bid_quotation_details.id AS bid_quotation_detail_id', :transporter_id, :bid_id, 'bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff').order('bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff')
        records.each do |bid_quotation_detail|
          bid_quo_det_obj = BidQuotationDetail.find(bid_quotation_detail.bid_quotation_detail_id)
          if (@current_tariff < 0 && @current_location_id < 0 && @current_warehouse_id < 0)

            bid_quo_det_obj.rank = @current_rank
            @current_tariff = bid_quo_det_obj.tariff
            @current_location_id = bid_quo_det_obj.location_id
            @current_warehouse_id = bid_quo_det_obj.warehouse_id
            puts "Case 1: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
          elsif (bid_quo_det_obj.tariff == @current_tariff && bid_quo_det_obj.location_id == @current_location_id && bid_quo_det_obj.warehouse_id == @current_warehouse_id)

            @current_tariff = bid_quo_det_obj.tariff
            @current_location_id = bid_quo_det_obj.location_id
            @current_warehouse_id = bid_quo_det_obj.warehouse_id
            bid_quo_det_obj.rank = @current_rank
            puts "Case 2: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
          elsif (bid_quo_det_obj.tariff > @current_tariff && bid_quo_det_obj.location_id == @current_location_id && bid_quo_det_obj.warehouse_id == @current_warehouse_id)

            @current_rank = @current_rank + 1
            @current_tariff = bid_quo_det_obj.tariff
            @current_location_id = bid_quo_det_obj.location_id
            @current_warehouse_id = bid_quo_det_obj.warehouse_id
            bid_quo_det_obj.rank = @current_rank
            puts "Case 3: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
          elsif (bid_quo_det_obj.location_id != @current_location_id || bid_quo_det_obj.warehouse_id != @current_warehouse_id)

            @current_rank = 1
            bid_quo_det_obj.rank = @current_rank
            @current_tariff = bid_quo_det_obj.tariff
            @current_location_id = bid_quo_det_obj.location_id
            @current_warehouse_id = bid_quo_det_obj.warehouse_id
            puts "Case 4: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
          else

            @current_rank = @current_rank + 1
            bid_quo_det_obj.rank = @current_rank
            @current_tariff = bid_quo_det_obj.tariff
            @current_location_id = bid_quo_det_obj.location_id
            @current_warehouse_id = bid_quo_det_obj.warehouse_id
            puts "Case 5: BidQuotationDetail: #{bid_quo_det_obj.id}. Current_Rank: #{@current_rank}, Current_Location: #{@current_location_id}, Current_Warehouse: #{@current_warehouse_id}, CurrentTariff: #{@current_tariff}, Bid_Tariff: #{bid_quo_det_obj.tariff}"
          end
          if (bid_quo_det_obj.save)
            @bid = Bid.find(id)
            @bid.status = :active
            @bid.save
            @result = true
          end  
        end
        records = BidQuotation.joins(:bid_quotation_details).where(:bid_id => params[:id]).select(:id, 'bid_quotation_details.id AS bid_quotation_detail_id', :transporter_id, :bid_id, 'bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff').order('bid_quotation_details.location_id', 'bid_quotation_details.warehouse_id', 'bid_quotation_details.tariff')
        return @result
    end

    def regenerate_bid_winners(id)
       @result = false
        @bid_quotations = BidQuotation.where(:bid_id => id)
        @bid_quotations.each do |bid_quotation|
            if bid_quotation&.bid_quotation_details.update_all(rank: nil)
                @bid = Bid.find(id)
                @bid.status = :draft
                @bid.save
                @result = true
            else
               @result = false
            end
        end
        
        
        return  @result
    end
    
end
