require 'test_helper'

class OperationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @operation = operations(:operation1)
  end

  test "should get index" do
    get operations_url
    assert_response :success
  end

  test "should get new" do
    get new_operation_url
    assert_response :success
  end

  test "should create operation" do
    assert_difference('Operation.count') do
      post operations_url, params: { operation: { 

    program_id: 1,
    hrd_id: 1,
    fscd_annual_plan_id: '',
    name: 'Meher 2009',
    descripiton: '',
    year: 2009,
    round: 1,
    month: '',
    expected_start: '1/1/2009',
    expected_end: '2/1/2009',
    actual_start: '1/1/2009',
    actual_end: '2/1/2009',
    status: :draft,
    ration_id: 1
       } }
    end

    assert_redirected_to operation_url(Operation.last)
  end
=begin
  test "should show operation" do
    get operation_url('en',@operation)
    assert_response :success
  end
=end
  test "should get edit" do
    get edit_operation_url('en',@operation)
    assert_response :success
  end

  test "should update operation" do
    patch operation_url('en',@operation), params: { operation: { 

    program_id: 1,
    hrd_id: 1,
    fscd_annual_plan_id: '',
    name: 'Meher 2009',
    descripiton: '',
    year: 2009,
    round: 1,
    month: '',
    expected_start: '1/1/2009',
    expected_end: '2/1/2009',
    actual_start: '1/1/2009',
    actual_end: '2/1/2009',
    status: :draft,
    ration_id: 1

     } }
    assert_redirected_to operation_url(@operation)
  end

  test "should destroy operation" do
    assert_difference('Operation.count', -1) do
      delete operation_url('en',@operation)
    end

    assert_redirected_to operations_url
  end
end
