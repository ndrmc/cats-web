# == Schema Information
#
# Table name: hubs
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class HubTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
