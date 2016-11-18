require 'test_helper'

class StoreLocationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @store_location = store_locations(:one)
  end

  test "should get index" do
    get store_locations_url
    assert_response :success
  end

  test "should get new" do
    get new_store_location_url
    assert_response :success
  end

  test "should create store_location" do
    assert_difference('StoreLocation.count') do
      post store_locations_url, params: { store_location: { description: @store_location.description, location_id: @store_location.location_id, name: @store_location.name } }
    end

    assert_redirected_to store_location_url(StoreLocation.last)
  end

  test "should show store_location" do
    get store_location_url(@store_location)
    assert_response :success
  end

  test "should get edit" do
    get edit_store_location_url(@store_location)
    assert_response :success
  end

  test "should update store_location" do
    patch store_location_url(@store_location), params: { store_location: { description: @store_location.description, location_id: @store_location.location_id, name: @store_location.name } }
    assert_redirected_to store_location_url(@store_location)
  end

  test "should destroy store_location" do
    assert_difference('StoreLocation.count', -1) do
      delete store_location_url(@store_location)
    end

    assert_redirected_to store_locations_url
  end
end
