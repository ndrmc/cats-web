# == Schema Information
#
# Table name: fdps
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  description :string
#  lat         :float
#  lon         :float
#  active      :boolean
#  location_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'test_helper'

class FdpTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
