class FrameworkTender < ApplicationRecord
     enum status: [:open, :closed]
     validates :year, :half_year,:presence => true
     validates_uniqueness_of :year, :scope => :half_year
     has_many :bids
     belongs_to :user, foreign_key: 'certified_by'

end
