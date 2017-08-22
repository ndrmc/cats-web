require 'test_helper'

class TransportOrdersControllerTest < ActionDispatch::IntegrationTest
  
    include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:admin)
    @transport_order = transport_orders(:transport_order_1)
  end

  test "should get index" do
    get transport_orders_url
    assert_response :success
  end

  test "should get new" do
    get new_transport_order_url
    assert_response :success
  end

  test "should create transport_order" do
    assert_difference('TransportOrder.count') do
      post transport_orders_url, params: { transport_order: { order_no: '002', operation_id: 1, region_id: 1, transporter_id: 1, bid_id: 1, 
      transport_order_items: [{
        commodity_id: 1, quantity: 20, tariff: 2, fdp_id: 1, store_id: 1
      }] } }
    end

    assert_redirected_to transport_order_url(TransportOrder.last)
  end

  test "should show transport_order" do
    get transport_order_url('en',@transport_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_transport_order_url("en",@transport_order)
    assert_response :success
  end

  test "should update transport_order" do
    patch transport_order_url('en',@transport_order), params: { transport_order: { id: @transport_order.id, order_no:  @transport_order.order_no  } }
    assert_redirected_to transport_order_url(@transport_order)
  end

  test "should destroy transport_order" do
    assert_difference('TransportOrder.count', -1) do
      delete transport_order_url("en",@transport_order)
    end

    assert_redirected_to transport_orders_url
  end
end
