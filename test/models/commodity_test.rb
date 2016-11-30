# == Schema Information
#
# Table name: commodities
#
#  id                    :integer          not null, primary key
#  name                  :string           not null
#  name_am               :string
#  long_name             :string
#  code                  :string           not null
#  code_am               :string
#  description           :text
#  hazardous             :boolean
#  cold_storage          :boolean
#  min_temperature       :float
#  max_temperature       :float
#  commodity_category_id :integer
#  unit_of_measure_id    :integer
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#  created_by            :integer
#  modified_by           :integer
#  deleted_at            :datetime
#

require 'test_helper'

class CommodityTest < ActiveSupport::TestCase
  test "should not save commodity without name" do
    commodity = Commodity.new
    assert_not commodity.save, "Saved commodity without a name"
  end


end
