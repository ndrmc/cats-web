# == Schema Information
#
# Table name: bid_quotation_details
#
#  id               :integer          not null, primary key
#  bid_quotation_id :integer
#  warehouse_id     :integer
#  location_id      :integer
#  tariff           :decimal(, )
#  remark           :text
#  created_by       :integer
#  modified_by      :integer
#  deleted_at       :datetime
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  rank             :integer
#

class BidQuotationDetail < ApplicationRecord
  belongs_to :bid_quotation
  belongs_to :warehouse
  belongs_to :location
end
