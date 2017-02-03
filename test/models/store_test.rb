# == Schema Information
#
# Table name: stores
#
#  id                :integer          not null, primary key
#  name              :string           not null
#  temporary         :boolean
#  warehouse_id      :integer
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  created_by        :integer
#  modified_by       :integer
#  deleted_at        :datetime
#  store_keeper_name :string
#

require 'test_helper'

class StoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
