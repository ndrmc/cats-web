require 'test_helper'

class UnitOfMeasuresControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:admin)
    @unit_of_measure = unit_of_measures(:unit_of_measure_1)
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
    get unit_of_measure_url('en',@unit_of_measure)
    assert_response :success
  end

  test "should get edit" do
    get edit_unit_of_measure_url('en',@unit_of_measure)
    assert_response :success
  end

  test "should update unit_of_measure" do
    patch unit_of_measure_url('en',@unit_of_measure), params: { unit_of_measure: { 

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
      delete unit_of_measure_url('en',@unit_of_measure)
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
  duplicate_unit_of_measure = @unit_of_measure.dup
  @unit_of_measure.save
  assert_not duplicate_unit_of_measure.valid?
end
end