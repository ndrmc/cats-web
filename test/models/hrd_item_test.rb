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
#

require 'test_helper'

class HrdItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
