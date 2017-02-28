require 'test_helper'

class RegionalRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @regional_request = regional_requests(:one)
  end

  test "should get index" do
    get regional_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_regional_request_url
    assert_response :success
  end

  test "should create regional_request" do
    assert_difference('RegionalRequest.count') do
      post regional_requests_url, params: { regional_request: { operation_id: @regional_request.operation_id, program_id: @regional_request.program_id, ration_id: @regional_request.ration_id, reference_number: @regional_request.reference_number, remark: @regional_request.remark, requested_date: @regional_request.requested_date } }
    end

    assert_redirected_to regional_request_url(RegionalRequest.last)
  end

  test "should show regional_request" do
    get regional_request_url(@regional_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_regional_request_url(@regional_request)
    assert_response :success
  end

  test "should update regional_request" do
    patch regional_request_url(@regional_request), params: { regional_request: { operation_id: @regional_request.operation_id, program_id: @regional_request.program_id, ration_id: @regional_request.ration_id, reference_number: @regional_request.reference_number, remark: @regional_request.remark, requested_date: @regional_request.requested_date } }
    assert_redirected_to regional_request_url(@regional_request)
  end

  test "should destroy regional_request" do
    assert_difference('RegionalRequest.count', -1) do
      delete regional_request_url(@regional_request)
    end

    assert_redirected_to regional_requests_url
  end
end
