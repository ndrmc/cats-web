require 'test_helper'

class PsnpPlanItemsControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @psnp_plan_item = psnp_plan_items(:one)
  end

  test "should get index" do
    get psnp_plans_item
    assert_response :success
  end

  test "should get new" do
    get new_psnp_plan_item_url
    assert_response :success
  end

  test "should create psnp_plan_item" do
    assert_difference('PsnpPlanItem.count') do
      post psnp_plan_items_url, params: { psnp_plan_item: {  } }
    end

    assert_redirected_to psnp_plan_item_url(PsnpPlanItem.last)
  end

  test "should show psnp_plan_item" do
    get psnp_plan_item_url(@psnp_plan_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_psnp_plan_item_url(@psnp_plan_item)
    assert_response :success
  end

  test "should update psnp_plan_item" do
    patch psnp_plan_item_url(@psnp_plan_item), params: { psnp_plan_item: {  } }
    assert_redirected_to psnp_plan_item_url(@psnp_plan_item)
  end

  test "should destroy psnp_plan_item" do
    assert_difference('PsnpPlanItem.count', -1) do
      delete psnp_plan_item_url(@psnp_plan_item)
    end

    assert_redirected_to psnp_plan_items_url
  end
end
