# == Schema Information
#
# Table name: warehouses
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  hub_id      :integer
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class StoreLocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
