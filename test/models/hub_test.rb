# == Schema Information
#
# Table name: hubs
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  lat         :decimal(15, 13)
#  lon         :decimal(15, 13)
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  created_by  :integer
#  modified_by :integer
#  deleted_at  :datetime
#

require 'test_helper'

class HubTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
