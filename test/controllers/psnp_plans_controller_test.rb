require 'test_helper'

class PsnpPlansControllerTest < ActionDispatch::IntegrationTest
  setup do
    @psnp_plan = psnp_plans(:one)
  end

  test "should get index" do
    get psnp_plans_url
    assert_response :success
  end

  test "should get new" do
    get new_psnp_plan_url
    assert_response :success
  end

  test "should create psnp_plan" do
    assert_difference('PsnpPlan.count') do
      post psnp_plans_url, params: { psnp_plan: {  } }
    end

    assert_redirected_to psnp_plan_url(PsnpPlan.last)
  end

  test "should show psnp_plan" do
    get psnp_plan_url(@psnp_plan)
    assert_response :success
  end

  test "should get edit" do
    get edit_psnp_plan_url(@psnp_plan)
    assert_response :success
  end

  test "should update psnp_plan" do
    patch psnp_plan_url(@psnp_plan), params: { psnp_plan: {  } }
    assert_redirected_to psnp_plan_url(@psnp_plan)
  end

  test "should destroy psnp_plan" do
    assert_difference('PsnpPlan.count', -1) do
      delete psnp_plan_url(@psnp_plan)
    end

    assert_redirected_to psnp_plans_url
  end
end
