# == Schema Information
#
# Table name: regional_requests
#
#  id               :integer          not null, primary key
#  operation_id     :integer
#  reference_number :string
#  region_id        :integer
#  ration_id        :integer
#  requested_date   :datetime
#  program_id       :integer
#  remark           :text
#  created_by       :integer
#  modified_by      :integer
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  generated        :boolean
#

class RegionalRequest < ApplicationRecord

    belongs_to :operation
    belongs_to :program 
    belongs_to :location, class_name: 'Location', foreign_key: 'region_id'

    has_many :regional_request_items
    has_many :requisitions,  :class_name => 'Requisition', :foreign_key => 'request_id'
    def region 
        Location.find region_id
    end
    

end 
