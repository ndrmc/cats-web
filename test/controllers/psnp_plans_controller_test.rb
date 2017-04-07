require 'test_helper'

class PsnpPlansControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
     sign_in users(:admin)
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
      post psnp_plans_url, params: { psnp_plan: { 
         year_ec: '2009', year_gc: '2017', month_from: 1, ration_id: 1, duration: 6
       } }
    end

    assert_redirected_to psnp_plans_url
  end

  test "should show psnp_plan" do
    get psnp_plans_url
    assert_response :success
  end

  test "should get edit" do
    get edit_psnp_plan_url(id: @psnp_plan.id)
    assert_response :success
  end

  test "should update psnp_plan" do
    patch psnp_plan_url(id: @psnp_plan.id), params: { psnp_plan: {
       year_ec: '2009', year_gc: '2017', month_from: 1,ration_id: 1, duration: 6
      } }
    assert_redirected_to psnp_plans_url
  end

  test "should destroy psnp_plan" do
     get "/psnp_plans/archive/#{@psnp_plan.id}"
    assert_equal(@psnp_plan.status.to_i, PsnpPlan.statuses[:archived])

    assert_redirected_to psnp_plans_url
  end
end
