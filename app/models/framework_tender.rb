class FrameworkTender < ApplicationRecord
     enum status: [:draft, :approved, :canceled, :closed, :archived]
     validates :year, :half_year,:presence => true
     validates_uniqueness_of :year, :scope => :half_year
     has_many :bids
     belongs_to :user, foreign_key: 'certified_by'

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
