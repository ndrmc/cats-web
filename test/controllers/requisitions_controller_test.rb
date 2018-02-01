require 'test_helper'

class RequisitionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @operation = operations(:operation1)
    @requisition = requisitions(:requisition1)
  end

  test "should get index" do
    get requisitions_url
    assert_response :success
  end

  test "should get new" do
    get new_requisition_url
    assert_response :success
  end


  test "should show requisition" do
    get requisition_url('en',@requisition)
    assert_response :success
  end

  test "should get edit" do
    get edit_requisition_url('en',@requisition)
    assert_response :success
  end

  test "should update requisition" do
    patch requisition_url('en',@requisition), params: { requisition: { 


       requisition_no: '005',
       operation_id: 1,
       commodity_id: 1,
       region_id: 1,
       zone_id: 1,
       ration_id: 1,
       requested_by: 'abebe',
       requested_on: '1/1/2009',
       status: :draft

     } }
    assert_redirected_to edit_requisition_url(@requisition)
  end

  test "should destroy requisition" do
    assert_difference('Requisition.count', -1) do
      delete requisition_url('en',@requisition)
    end

    assert_redirected_to requisitions_url
  end
end
