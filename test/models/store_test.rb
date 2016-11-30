# == Schema Information
#
# Table name: stores
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  temporary         :boolean
#  hub_id            :integer
#  store_owner_id    :integer
#  store_location_id :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by        :integer
#  modified_by       :integer
#  deleted_at        :datetime
#

require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
