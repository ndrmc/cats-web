require 'test_helper'

class RationItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ration_item = ration_items(:one)
  end

  test "should get index" do
    get ration_items_url
    assert_response :success
  end

  test "should get new" do
    get new_ration_item_url
    assert_response :success
  end

  test "should create ration_item" do
    assert_difference('RationItem.count') do
      post ration_items_url, params: { ration_item: { amount: @ration_item.amount } }
    end

    assert_redirected_to ration_item_url(RationItem.last)
  end

  test "should show ration_item" do
    get ration_item_url(@ration_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_ration_item_url(@ration_item)
    assert_response :success
  end

  test "should update ration_item" do
    patch ration_item_url(@ration_item), params: { ration_item: { amount: @ration_item.amount } }
    assert_redirected_to ration_item_url(@ration_item)
  end

  test "should destroy ration_item" do
    assert_difference('RationItem.count', -1) do
      delete ration_item_url(@ration_item)
    end

    assert_redirected_to ration_items_url
  end
end
