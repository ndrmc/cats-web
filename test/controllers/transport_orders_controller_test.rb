require 'test_helper'

class TransportOrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transport_order = transport_orders(:one)
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
      post transport_orders_url, params: { transport_order: {  } }
    end

    assert_redirected_to transport_order_url(TransportOrder.last)
  end

  test "should show transport_order" do
    get transport_order_url(@transport_order)
    assert_response :success
  end

  test "should get edit" do
    get edit_transport_order_url(@transport_order)
    assert_response :success
  end

  test "should update transport_order" do
    patch transport_order_url(@transport_order), params: { transport_order: {  } }
    assert_redirected_to transport_order_url(@transport_order)
  end

  test "should destroy transport_order" do
    assert_difference('TransportOrder.count', -1) do
      delete transport_order_url(@transport_order)
    end

    assert_redirected_to transport_orders_url
  end
end
