# == Schema Information
#
# Table name: regional_request_items
#
#  id                      :integer          not null, primary key
#  regional_request_id     :integer
#  fdp_id                  :integer
#  number_of_beneficiaries :decimal(, )
#  created_by              :integer
#  modified_by             :integer
#  deleted_at              :datetime
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#


class RegionalRequestItem < ApplicationRecord
    belongs_to :regional_request
    belongs_to :fdp
end 
