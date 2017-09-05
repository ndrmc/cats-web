# == Schema Information
#
# Table name: warehouse_selections
#
#  id                  :integer          not null, primary key
#  framework_tender_id :integer
#  location_id         :integer
#  warehouse_id        :integer
#  estimated_qty       :decimal(, )
#  created_by          :integer
#  modified_by         :integer
#  deleted             :boolean
#  deleted_at          :datetime
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

require 'test_helper'

class WarehouseSelectionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
