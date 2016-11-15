require 'test_helper'

class LocationTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @location_type = location_types(:one)
  end

  test "should get index" do
    get location_types_url
    assert_response :success
  end

  test "should get new" do
    get new_location_type_url
    assert_response :success
  end

  test "should create location_type" do
    assert_difference('LocationType.count') do
      post location_types_url, params: { location_type: { description: @location_type.description, name: @location_type.name } }
    end

    assert_redirected_to location_type_url(LocationType.last)
  end

  test "should show location_type" do
    get location_type_url(@location_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_location_type_url(@location_type)
    assert_response :success
  end

  test "should update location_type" do
    patch location_type_url(@location_type), params: { location_type: { description: @location_type.description, name: @location_type.name } }
    assert_redirected_to location_type_url(@location_type)
  end

  test "should destroy location_type" do
    assert_difference('LocationType.count', -1) do
      delete location_type_url(@location_type)
    end

    assert_redirected_to location_types_url
  end
end
