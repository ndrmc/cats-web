require 'test_helper'

class LocationsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

  setup do
     sign_in users(:admin)
    @location = locations(:one)
  end

  test "should get index" do
    get locations_url
    assert_redirected_to location_url(id: 0)
  end

 
 # test "should create location" do
 #   assert_difference('Location.count') do
 #   post locations_url(parent_id: 0), params: { location: { name: 'Oroia' } }
 #   end

 #  assert_redirected_to location_url(id: Location.last.id)
 #end

  test "should show location" do
    get location_url(id: @location.id)
    assert_response :success
  end

  test "should get edit" do
    get edit_location_url(id: @location.id)
    assert_response :success
  end

#  test "should update location" do
#    patch location_url(@location), params: { location: { name: 'Amhara' } }
#   assert_redirected_to location_url(id: @location.id)
#  end

  test "should destroy location" do
      assert_difference('Location.count', -1) do
      delete location_url(id: @location.id)
  end

    assert_redirected_to location_url(id: 0)
  end
end
