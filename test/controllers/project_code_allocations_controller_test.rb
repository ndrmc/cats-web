require 'test_helper'

class ProjectCodeAllocationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @project_code_allocation = project_code_allocations(:pc_allocation_1)
    @requisition = requisitions(:requisition3)
    @project = projects(:project5)
    @commodity = commodities(:commodity_1)
  end

  test "should get index" do
    get project_code_allocations_url
    assert_response :success
  end

  test "should get new" do
    get new_project_code_allocation_url
    assert_response :success
  end

  test "should create project_code_allocation" do
    assert_difference('ProjectCodeAllocation.count') do
      post project_code_allocations_url, params: { project_code_allocation: { amount: @project_code_allocation.amount, fdp_id: @project_code_allocation.fdp_id, hub_id: @project_code_allocation.hub_id, operation_id: @project_code_allocation.operation_id, project_id: @project_code_allocation.project_id, requisition_id: @project_code_allocation.requisition_id, store_id: @project_code_allocation.store_id, unit_of_measure_id: @project_code_allocation.unit_of_measure_id, warehouse_id: @project_code_allocation.warehouse_id } }
    end

    assert_redirected_to project_code_allocation_url('en',ProjectCodeAllocation.last)
  end

  test "should show project_code_allocation" do
    get project_code_allocation_url('en',@requisition)
    assert_response :success
  end

  test "should get edit" do
    get edit_project_code_allocation_url('en',@project_code_allocation)
    assert_response :success
  end

  test "should update project_code_allocation" do
    patch project_code_allocation_url('en',@project_code_allocation), params: { project_code_allocation: { amount: @project_code_allocation.amount, fdp_id: @project_code_allocation.fdp_id, hub_id: @project_code_allocation.hub_id, operation_id: @project_code_allocation.operation_id, project_id: @project_code_allocation.project_id, requisition_id: @project_code_allocation.requisition_id, store_id: @project_code_allocation.store_id, unit_of_measure_id: @project_code_allocation.unit_of_measure_id, warehouse_id: @project_code_allocation.warehouse_id } }
    assert_redirected_to project_code_allocation_url(@project_code_allocation)
  end

  test "should destroy project_code_allocation" do
    assert_difference('ProjectCodeAllocation.count', -1) do
      delete project_code_allocation_url('en',@project_code_allocation)
    end

    assert_redirected_to project_code_allocations_url
  end
end
