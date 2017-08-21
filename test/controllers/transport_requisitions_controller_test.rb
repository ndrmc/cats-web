require 'test_helper'

class TransportRequisitionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transport_requisition = transport_requisitions(:one)
  end

  test "should get index" do
    get transport_requisitions_url
    assert_response :success
  end

  test "should get new" do
    get new_transport_requisition_url
    assert_response :success
  end

  test "should create transport_requisition" do
    assert_difference('TransportRequisition.count') do
      post transport_requisitions_url, params: { transport_requisition: { certified_by: @transport_requisition.certified_by, certified_date: @transport_requisition.certified_date, deleted_at: @transport_requisition.deleted_at, location_id: @transport_requisition.location_id, operation_id: @transport_requisition.operation_id, reference_number: @transport_requisition.reference_number, description: @transport_requisition.description, status: @transport_requisition.status } }
    end

    assert_redirected_to transport_requisition_url(TransportRequisition.last)
  end

  test "should show transport_requisition" do
    get transport_requisition_url(@transport_requisition)
    assert_response :success
  end

  test "should get edit" do
    get edit_transport_requisition_url(@transport_requisition)
    assert_response :success
  end

  test "should update transport_requisition" do
    patch transport_requisition_url(@transport_requisition), params: { transport_requisition: { certified_by: @transport_requisition.certified_by, certified_date: @transport_requisition.certified_date, deleted_at: @transport_requisition.deleted_at, location_id: @transport_requisition.location_id, operation_id: @transport_requisition.operation_id, reference_number: @transport_requisition.reference_number, description: @transport_requisition.description, status: @transport_requisition.status } }
    assert_redirected_to transport_requisition_url(@transport_requisition)
  end

  test "should destroy transport_requisition" do
    assert_difference('TransportRequisition.count', -1) do
      delete transport_requisition_url(@transport_requisition)
    end

    assert_redirected_to transport_requisitions_url
  end
end
