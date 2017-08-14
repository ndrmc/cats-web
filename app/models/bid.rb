class Bid < ApplicationRecord
    belongs_to :location, foreign_key: 'region_id'
    belongs_to :framework_tender, foreign_key: 'framework_tender_id'
   
    enum status: [:draft, :approved, :canceled, :closed, :archived]

     def self.get_index(status)
         if status == 'approved'
             return :approved
         elsif status == 'canceled'
             return :canceled
         elsif status == 'closed'
             return :closed
        elsif status == 'archived'
            return :archived
        else
            return :draft
        end
    end

    def self.generate_bid_winners (id)
        current_rank = 1
        current_tariff = -1
        current_location_id = -1
        current_warehouse_id = -1
        result = false
        BidQuotationDetail.joins(:bid_quotation).where(:bid_id => id).order(location_id: :asc, warehouse_id: :asc, tariff: :asc)
          .find_each do |bid_quotation_detail|
            if (current_tariff < 0 && current_location_id < 0 && current_warehouse_id < 0)

              bid_quotation_detail.rank = current_rank
              current_tariff = bid_quotation_detail.tariff
              current_location_id = bid_quotation_detail.location_id
              current_warehouse_id = bid_quotation_detail.warehouse_id

            elsif (bid_quotation_detail.tariff == current_tariff && bid_quotation_detail.location_id == current_location_id && bid_quotation_detail.warehouse_id == current_warehouse_id)

              bid_quotation_detail.rank = current_rank

            elsif (bid_quotation_detail.tariff > current_tariff && bid_quotation_detail.location_id == current_location_id && bid_quotation_detail.warehouse_id == current_warehouse_id)

              current_rank = current_rank + 1
              bid_quotation_detail.rank = current_rank

            elsif (bid_quotation_detail.location_id != current_location_id || bid_quotation_detail.warehouse_id != current_warehouse_id)

              current_rank = 1
              bid_quotation_detail.rank = current_rank
              current_tariff = bid_quotation_detail.tariff
              current_location_id = bid_quotation_detail.location_id
              current_warehouse_id = bid_quotation_detail.warehouse_id

            else

              current_rank = current_rank + 1
              bid_quotation_detail.rank = current_rank
              current_tariff = bid_quotation_detail.tariff
              current_location_id = bid_quotation_detail.location_id
              current_warehouse_id = bid_quotation_detail.warehouse_id

            end
            if (bid_quotation_detail.save)
                result = true
            end  
          end
        return result
    end
end
