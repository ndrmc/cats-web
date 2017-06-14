require 'test_helper'

class UnitOfMeasuresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:admin)
    @unit_of_measure_mt = unit_of_measures(:unit_of_measure_1)
    @unit_of_measure_kg = unit_of_measures(:unit_of_measure_2)
    @unit_of_measure_qtl = unit_of_measures(:unit_of_measure_3)
  end

  test "should get index" do
    get unit_of_measures_url
    assert_response :success
  end

  test "should get new" do
    get new_unit_of_measure_url
    assert_response :success
  end

  test "should create unit_of_measure" do
    assert_difference('UnitOfMeasure.count') do
      post unit_of_measures_url, params: { unit_of_measure: {     name: 'mt',     
    description: 'Meteric Ton',
    code: 'm',
    uom_type: :ref,
    ratio: 1,   
    uom_category_id: 1 } }
    end

    assert_redirected_to unit_of_measures_url
  end

  test "should show unit_of_measure" do
    get unit_of_measure_url('en',@unit_of_measure_mt)
    assert_response :success
  end

  test "should get edit" do
    get edit_unit_of_measure_url('en',@unit_of_measure_mt)
    assert_response :success
  end

  test "should update unit_of_measure" do
    patch unit_of_measure_url('en',@unit_of_measure_mt), params: { unit_of_measure: { 

    name:  'mt',     
    description: 'Meteric Ton',
    code:   'MT',       
    ratio: 1,       
    uom_category:1 

     } }
    assert_redirected_to unit_of_measures_url
  end

  test "should destroy unit_of_measure" do
    assert_difference('UnitOfMeasure.count', -1) do
      delete unit_of_measure_url('en',@unit_of_measure_mt)
    end

    assert_redirected_to unit_of_measures_url
  end

  test "name,code,uom type, ration and category unit id must not be blank" do 
  new_unit_of_measure = UnitOfMeasure.new(name: ' ', code: ' ', uom_type: ' ', ratio: ' ' , uom_category_id: ' ')
  assert !new_unit_of_measure.valid?
end

test "name,code,uom type, ration and category unit id must not be nil" do 
  new_unit_of_measure = UnitOfMeasure.new(name: nil , code: nil, uom_type: nil, ratio:nil , uom_category_id: nil)
  assert !new_unit_of_measure.valid?
end

test "code must be unique" do
  duplicate_unit_of_measure = @unit_of_measure_mt.dup
  @unit_of_measure_mt.save
  assert_not duplicate_unit_of_measure.valid?
end

test "to_ref method in model" do
  value = 20
  assert_equal(value, @unit_of_measure_kg.to_ref(value))
  assert_equal(value * 1000, @unit_of_measure_mt.to_ref(value))
  assert_equal(value * 100, @unit_of_measure_qtl.to_ref(value))
end

test "ref_to_unit in model" do
  value = 20
  assert_equal(0, @unit_of_measure_kg.ref_to_unit(value))
  assert_equal(0.02, @unit_of_measure_mt.ref_to_unit(value))
  assert_equal(0.2, @unit_of_measure_qtl.ref_to_unit(value))
end

test "convert_to in model" do
  value = 20
  expected_unit = 'mt'

  assert_equal(200,@unit_of_measure_qtl.convert_to(expected_unit,value))
end


end