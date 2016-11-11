# == Schema Information
#
# Table name: bid_plan_items
#
#  id                 :integer          not null, primary key
#  bid_plan_id        :integer
#  woreda_id          :integer
#  store_id           :integer
#  quantity           :decimal(, )
#  unit_of_measure_id :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class BidPlanItem < ApplicationRecord
  belongs_to :bid_plan
end
