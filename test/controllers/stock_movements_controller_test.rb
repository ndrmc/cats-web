require 'test_helper'

class StockMovementsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @stock_movement = stock_movements(:one)
  end

  test "should get index" do
    get stock_movements_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_movement_url
    assert_response :success
  end

  test "should create stock_movement" do
    assert_difference('StockMovement.count') do
      post stock_movements_url, params: { stock_movement: { commodity_id: @stock_movement.commodity_id, description: @stock_movement.description, destination_hub_id: @stock_movement.destination_hub_id, destination_store_id: @stock_movement.destination_store_id, destination_warehouse_id: @stock_movement.destination_warehouse_id, project_id: @stock_movement.project_id, quantity: @stock_movement.quantity, source_hub_id: @stock_movement.source_hub_id, source_store_id: @stock_movement.source_store_id, source_warehouse_id: @stock_movement.source_warehouse_id } }
    end

    assert_redirected_to stock_movement_url(StockMovement.last)
  end

  test "should show stock_movement" do
    get stock_movement_url("en",@stock_movement)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_movement_url("en",@stock_movement)
    assert_response :success
  end

  test "should update stock_movement" do
    patch stock_movement_url("en",@stock_movement), params: { stock_movement: { commodity_id: @stock_movement.commodity_id, description: @stock_movement.description, destination_hub_id: @stock_movement.destination_hub_id, destination_store_id: @stock_movement.destination_store_id, destination_warehouse_id: @stock_movement.destination_warehouse_id, project_id: @stock_movement.project_id, quantity: @stock_movement.quantity, source_hub_id: @stock_movement.source_hub_id, source_store_id: @stock_movement.source_store_id, source_warehouse_id: @stock_movement.source_warehouse_id } }
    assert_redirected_to stock_movement_url(@stock_movement)
  end

  test "should destroy stock_movement" do
    assert_difference('StockMovement.count', -1) do
      delete stock_movement_url("en",@stock_movement)
    end

    assert_redirected_to stock_movements_url
  end
end
