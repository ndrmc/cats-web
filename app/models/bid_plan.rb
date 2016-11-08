# == Schema Information
#
# Table name: bid_plans
#
#  id          :integer          not null, primary key
#  year        :string           not null
#  half_year   :integer
#  program_id  :integer
#  code        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class BidPlan < ApplicationRecord
  has_many :bid_plan_items
  has_many :bids
end
