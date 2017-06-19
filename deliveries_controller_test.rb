require 'test_helper'

class DeliveriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  
  setup do
    sign_in users(:admin)
    @fdp = fdps(:fdp1)
    @delivery = deliveries(:delivery1)
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
      post deliveries_url, params: { delivery: { 

  receiving_number: '00178',
  transporter_id: 1,
  fdp_id: @fdp.id,
  gin_number: 0001, 
  requisition_number: '9000',
  received_by: 'Mola',
  received_date: '1/1/2009',
  status: 1,
  operation_id: 1,
  draft: true,
  remark: '',
  delivery_details: [{
 commodity_id: 1,
 uom_id: 1,
 sent_quantity: 100,
 received_quantity: 100
  }]

       } }
    end

    assert_redirected_to deliveries_url
  end

#  test "should show delivery" do
#    get delivery_url('en',@delivery)
#    assert_response :success
#  end

  test "should get edit" do
    get edit_delivery_url('en',@delivery)
    assert_response :success
  end
=begin
  test "should update delivery" do
    patch delivery_url('en',@delivery), params: { delivery: { 

  receiving_number: '001',
  transporter_id: 1,
  fdp_id: @fdp.id,
  gin_number: '0001',
  requisition_number: '002',
  received_by: 'Mola',
  received_date: '1/1/2009',
  status:1 ,
  operation_id: 1,
  remark: '',

  delivery_details: [{
  commodity_id: 1,
  uom_id: 1,
  sent_quantity: 100,
 received_quantity: 100,
 delivery_id: 1  
  }]

     } }
    assert_redirected_to delivery_url(@delivery)
  end
=end
  test "should destroy delivery" do
    assert_difference('Delivery.count', -1) do
      delete delivery_url('en',@delivery)
    end

    assert_redirected_to deliveries_url
  end
end
