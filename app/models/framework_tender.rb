# == Schema Information
#
# Table name: framework_tenders
#
#  id             :integer          not null, primary key
#  year           :integer
#  half_year      :integer
#  starting_month :integer
#  ending_month   :integer
#  status         :integer
#  remark         :text
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  certified_by   :integer
#

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
