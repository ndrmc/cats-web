require 'test_helper'

class FrameworkTendersControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @framework_tender = framework_tenders(:framework_tenders_1)
  end

  test "should get index" do
    get framework_tenders_url
    assert_response :success
  end

  test "should get new" do
    get new_framework_tender_url
    assert_response :success
  end

  test "should create framework_tender" do
    assert_difference('FrameworkTender.count') do
      post framework_tenders_url, params: { framework_tender: { ending_month: @framework_tender.ending_month, half_year: @framework_tender.half_year, remark: @framework_tender.remark, starting_month: @framework_tender.starting_month, 
      status: :approved, year: 2012 } }
    end

    assert_redirected_to framework_tenders_path
  end

  test "should show framework_tender" do
    get framework_tender_url('en',@framework_tender)
    assert_response :success
  end

  test "should get edit" do
    get edit_framework_tender_url('en',@framework_tender)
    assert_response :success
  end

  test "should update framework_tender" do
    patch framework_tender_url('en',@framework_tender), params: { framework_tender: { ending_month: @framework_tender.ending_month, half_year: @framework_tender.half_year, remark: @framework_tender.remark, starting_month: @framework_tender.starting_month, status: @framework_tender.status, year: @framework_tender.year } }
      assert_response :success
  end

  test "should destroy framework_tender" do
    assert_difference('FrameworkTender.count', -1) do
      delete framework_tender_url('en',@framework_tender)
    end

    assert_redirected_to framework_tenders_url
  end
end
