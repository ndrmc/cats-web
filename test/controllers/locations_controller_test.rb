require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @location = locations(:location1)
  end

  test "should get index" do
    get locations_url
    assert_redirected_to location_url(@location.parent_id ? @location.parent_id : 0)
  end

#  test "should get new" do
#    get new_location_url
#    assert_response :success
#  end

#  test "should create location" do
#    assert_difference('Location.count') do
#      post locations_url, params: { location: { name: 'Oromia', code: 'OR', location_type: :region  } }
#    end

#  assert_redirected_to location_url(@location.parent_id ? @location.parent_id : 0)
#  end

  test "should show location" do
    get location_url('en',@location.parent_id ? @location.parent_id : 0)
    assert_response :success
  end

  test "should get edit" do
    get edit_location_url('en',@location)
    assert_response :success
  end

  test "should update location" do
    patch location_url('en',@location), params: { location: { name: 'Oromia', code: 'OR', location_type: :region   } }
    assert_redirected_to location_url(@location.parent_id ? @location.parent_id : 0)
  end

  test "should destroy location" do
    assert_difference('Location.count', -1) do
      delete location_url('en',@location)
    end

    assert_redirected_to location_url(@location.parent_id ? @location.parent_id : 0)
  end

  test "name should not be blank" do
    new_location = Location.new(name: ' ')
    assert !new_location.valid?
  end
  
end
