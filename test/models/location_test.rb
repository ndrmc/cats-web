# == Schema Information
#
# Table name: locations
#
#  id             :integer          not null, primary key
#  name           :string           not null
#  code           :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  ancestry       :string
#  location_type  :integer
#  created_by     :integer
#  modified_by    :integer
#  deleted_at     :datetime
#  parent_node_id :integer
#

require 'test_helper'

class LocationTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
