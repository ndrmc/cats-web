require 'test_helper'

class StockTakeItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @stock_take_item = stock_take_items(:one)
  end

  test "should get index" do
    get stock_take_items_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_take_item_url
    assert_response :success
  end

  test "should create stock_take_item" do
    assert_difference('StockTakeItem.count') do
      post stock_take_items_url, params: { stock_take_item: { actual_amount: @stock_take_item.actual_amount, commodity_category_id: @stock_take_item.commodity_category_id, commodity_id: @stock_take_item.commodity_id, stock_take_id: @stock_take_item.stock_take_id } }
    end

    assert_redirected_to stock_take_item_url(StockTakeItem.last)
  end

  test "should show stock_take_item" do
    get stock_take_item_url(@stock_take_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_take_item_url(@stock_take_item)
    assert_response :success
  end

  test "should update stock_take_item" do
    patch stock_take_item_url(@stock_take_item), params: { stock_take_item: { actual_amount: @stock_take_item.actual_amount, commodity_category_id: @stock_take_item.commodity_category_id, commodity_id: @stock_take_item.commodity_id, stock_take_id: @stock_take_item.stock_take_id } }
    assert_redirected_to stock_take_item_url(@stock_take_item)
  end

  test "should destroy stock_take_item" do
    assert_difference('StockTakeItem.count', -1) do
      delete stock_take_item_url(@stock_take_item)
    end

    assert_redirected_to stock_take_items_url
  end
end
