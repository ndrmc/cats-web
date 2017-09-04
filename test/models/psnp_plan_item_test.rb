# == Schema Information
#
# Table name: psnp_plan_items
#
#  id             :integer          not null, primary key
#  psnp_plan_id   :integer
#  woreda_id      :integer
#  duration       :integer
#  starting_month :integer
#  beneficiary    :integer
#  region_id      :integer
#  zone_id        :integer
#  cash_ratio     :integer
#  kind_ratio     :integer
#  created_by     :integer
#  modified_by    :integer
#  deleted        :boolean          default(FALSE)
#  deleted_at     :datetime
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#

require 'test_helper'

class PsnpPlanItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
