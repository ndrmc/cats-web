# == Schema Information
#
# Table name: unit_of_measures
#
#  id              :integer          not null, primary key
#  name            :string           not null
#  description     :string
#  code            :string           not null
#  uom_type        :integer          default("ref"), not null
#  ratio           :decimal(8, 2)    not null
#  uom_category_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  created_by      :integer
#  modified_by     :integer
#  deleted_at      :datetime
#

require 'test_helper'

class UnitOfMeasureTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:admin)
    @unit_of_measure_mt = unit_of_measures(:unit_of_measure_1)
    @unit_of_measure_kg = unit_of_measures(:unit_of_measure_2)
    @unit_of_measure_qtl = unit_of_measures(:unit_of_measure_3)
  end


  test "to_ref method in model" do
  value = 20
  assert_equal(0.02, @unit_of_measure_kg.to_ref(value))
  assert_equal(value, @unit_of_measure_mt.to_ref(value))
  assert_equal(0.2, @unit_of_measure_qtl.to_ref(value))
end

test "ref_to_unit in model" do
  value = 20
  assert_equal(value * 1000, @unit_of_measure_kg.ref_to_unit(value))
  assert_equal(value , @unit_of_measure_mt.ref_to_unit(value))
  assert_equal(value * 100, @unit_of_measure_qtl.ref_to_unit(value))
end

test "convert_to in model" do
  value = 20
  expected_unit = 'mt'

  assert_equal(2000,@unit_of_measure_qtl.convert_to(expected_unit,value))
end
end
