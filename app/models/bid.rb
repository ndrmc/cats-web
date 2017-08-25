class Bid < ApplicationRecord
    belongs_to :location, foreign_key: 'region_id'
    belongs_to :framework_tender, foreign_key: 'framework_tender_id'
   
    enum status: [:draft, :active, :closed]

     def self.get_index(status)
         if status == 'active'
             return :active
         elsif status == 'closed'
             return :closed
        else
            return :draft
        end
    end

    
end
