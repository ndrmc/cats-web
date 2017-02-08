require 'test_helper'

class DeliveriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delivery = deliveries(:one)
  end

  test "should get index" do
    get deliveries_url
    assert_response :success
  end

  test "should get new" do
    get new_delivery_url
    assert_response :success
  end

  test "should create delivery" do
    assert_difference('Delivery.count') do
      post deliveries_url, params: { delivery: { action_type: @delivery.action_type, action_type_remark: @delivery.action_type_remark, delivery_by: @delivery.delivery_by, delivery_date: @delivery.delivery_date, dispatch_id: @delivery.dispatch_id, document_received_by: @delivery.document_received_by, document_received_date: @delivery.document_received_date, donor_id: @delivery.donor_id, driver_name: @delivery.driver_name, fdp_id: @delivery.fdp_id, hub_id: @delivery.hub_id, invoice_number: @delivery.invoice_number, posting_id: @delivery.posting_id, primary_plate_number: @delivery.primary_plate_number, received_by: @delivery.received_by, received_date: @delivery.received_date, receiving_number: @delivery.receiving_number, requisition_number: @delivery.requisition_number, status: @delivery.status, trailer_plate_number: @delivery.trailer_plate_number, transporter_id: @delivery.transporter_id, waybill_number: @delivery.waybill_number } }
    end

    assert_redirected_to delivery_url(Delivery.last)
  end

  test "should show delivery" do
    get delivery_url(@delivery)
    assert_response :success
  end

  test "should get edit" do
    get edit_delivery_url(@delivery)
    assert_response :success
  end

  test "should update delivery" do
    patch delivery_url(@delivery), params: { delivery: { action_type: @delivery.action_type, action_type_remark: @delivery.action_type_remark, delivery_by: @delivery.delivery_by, delivery_date: @delivery.delivery_date, dispatch_id: @delivery.dispatch_id, document_received_by: @delivery.document_received_by, document_received_date: @delivery.document_received_date, donor_id: @delivery.donor_id, driver_name: @delivery.driver_name, fdp_id: @delivery.fdp_id, hub_id: @delivery.hub_id, invoice_number: @delivery.invoice_number, posting_id: @delivery.posting_id, primary_plate_number: @delivery.primary_plate_number, received_by: @delivery.received_by, received_date: @delivery.received_date, receiving_number: @delivery.receiving_number, requisition_number: @delivery.requisition_number, status: @delivery.status, trailer_plate_number: @delivery.trailer_plate_number, transporter_id: @delivery.transporter_id, waybill_number: @delivery.waybill_number } }
    assert_redirected_to delivery_url(@delivery)
  end

  test "should destroy delivery" do
    assert_difference('Delivery.count', -1) do
      delete delivery_url(@delivery)
    end

    assert_redirected_to deliveries_url
  end
end
