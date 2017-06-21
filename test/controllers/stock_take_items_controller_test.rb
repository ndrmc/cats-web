require 'test_helper'

class StockTakeItemsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
     @stock_take_item = stock_take_items(:stock_take_items_1)
    end


  test "should get new" do
    get new_stock_take_item_url(stock_take_id: @stock_take_item.stock_take_id)
    assert_response :success
  end

  test "should create stock_take_item" do
    assert_difference('StockTakeItem.count') do
      post stock_take_items_url, params: { stock_take_item: {
    
      actual_amount: @stock_take_item.actual_amount, 
      commodity_category_id: @stock_take_item.commodity_category_id, 
      commodity_id: @stock_take_item.commodity_id, 
      stock_take_id: @stock_take_item.stock_take_id,
      donor_id: 1,
      project_id: 1,
      theoretical_amount: 200  } }
    end

    assert_redirected_to stock_take_url(StockTakeItem.last.stock_take)
  end

  test "should get edit" do
    get edit_stock_take_item_url('en',@stock_take_item)
    assert_response :success
  end

  test "should update stock_take_item" do
    patch stock_take_item_url('en',@stock_take_item), params: { stock_take_item: { actual_amount: @stock_take_item.actual_amount, commodity_category_id: @stock_take_item.commodity_category_id, commodity_id: @stock_take_item.commodity_id, stock_take_id: @stock_take_item.stock_take_id } }
    assert_redirected_to stock_take_url(@stock_take_item.stock_take)
  end

  test "should destroy stock_take_item" do
    stock_take = @stock_take_item.stock_take
    assert_difference('StockTakeItem.count', -1) do
      delete stock_take_item_url('en',@stock_take_item)
    end

    assert_redirected_to stock_take_url(stock_take)
  end
end
