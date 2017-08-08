class FrameworkTender < ApplicationRecord
     enum status: [:draft, :approved, :canceled, :closed, :archived]
     validates :year, :half_year,:presence => true
     validates_uniqueness_of :year, :scope => :half_year
end
