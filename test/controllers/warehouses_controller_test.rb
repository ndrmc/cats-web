require 'test_helper'

class WarehousesControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
     sign_in users(:admin)
    @warehouse = warehouses(:one)
  end

  test "should get index" do
    get warehouses_url
    assert_response :success
  end

  test "should get new" do
    get new_warehouse_url
    assert_response :success
  end

  test "should create warehouse" do
    assert_difference('Warehouse.count') do
      post warehouses_url, params: { warehouse: {name: 'WH 1', description: 'Des', location_id: 1, organization_id: 1, lat: 0, lon: 0  } }
    end

    assert_redirected_to warehouses_url
  end

  test "should show warehouse" do
    get warehouses_url
    assert_response :success
  end

  test "should get edit" do
    get edit_warehouse_url(id: @warehouse.id)
    assert_response :success
  end

  test "should update warehouse" do
    patch warehouse_url(id: @warehouse.id), params: { warehouse: { name: 'WH 1', description: 'Des', location_id: 1, organization_id: 1, lat: 0, lon: 0  } }
    assert_redirected_to warehouse_url(id: @warehouse.id)
  end

  test "should destroy warehouse" do
    assert_difference('Warehouse.count', -1) do
      delete warehouse_url(@warehouse)
    end

    assert_redirected_to warehouse_url(@hub)
  end
end
