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

    
end
