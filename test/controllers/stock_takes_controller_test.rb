require 'test_helper'

class StockTakesControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
     @stock_take = stock_takes(:stock_take_1)
  end
  

  test "should get index" do
    get stock_takes_url
    assert_response :success
  end

  test "should get new" do
    get new_stock_take_url
    assert_response :success
  end

  test "should create stock_take" do
    assert_difference('StockTake.count') do
      post stock_takes_url, params: { stock_take: { title:'Title', date: @stock_take.date, hub_id: @stock_take.hub_id, store_no: @stock_take.store_no, warehouse_id: @stock_take.warehouse_id } }
    end

    assert_redirected_to stock_take_url(StockTake.last)
  end

  test "should show stock_take" do
    get stock_take_url('en',@stock_take)
    assert_response :success
  end

  test "should get edit" do
    get edit_stock_take_url('en',@stock_take)
    assert_response :success
  end

  test "should update stock_take" do
    patch stock_take_url('en',@stock_take), params: { stock_take: { date: @stock_take.date,  hub_id: @stock_take.hub_id, store_no: @stock_take.store_no, warehouse_id: @stock_take.warehouse_id } }
    assert_redirected_to stock_take_url(@stock_take)
  end

  test "should destroy stock_take" do
    assert_difference('StockTake.count', -1) do
      delete stock_take_url('en',@stock_take)
    end

    assert_redirected_to stock_takes_url
  end
end
