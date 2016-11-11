# == Schema Information
#
# Table name: locations
#
#  id               :integer          not null, primary key
#  name             :string           not null
#  code             :string
#  location_type_id :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  ancestry         :string
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
