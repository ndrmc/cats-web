# == Schema Information
#
# Table name: hrd_items
#
#  id             :integer          not null, primary key
#  hrd_id         :integer
#  woreda_id      :integer
#  duration       :integer
#  starting_month :integer
#  beneficiary    :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#  region_id      :integer
#  zone_id        :integer
#

require 'test_helper'

class HrdItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
