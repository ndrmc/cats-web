# == Schema Information
#
# Table name: regional_requests
#
#  id               :integer          not null, primary key
#  operation_id     :integer
#  reference_number :string
#  region_id        :integer
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

    has_many :regional_request_items

    def region 
        Location.find region_id
    end
    

end 
