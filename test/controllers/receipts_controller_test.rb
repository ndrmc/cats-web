require 'test_helper'

class ReceiptsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @receipt = receipts(:one)
  end

  test "should get index" do
    get receipts_url
    assert_response :success
  end

  test "should get new" do
    get new_receipt_url
    assert_response :success
  end

  test "should create receipt" do
    assert_difference('Receipt.count') do
      post receipts_url, params: { receipt: { grn_no: '12345' ,donor_id: '1',draft: true,commodity_source_id: 1,
                                   receipt_lines: [
                                     {commodity_category_id: 1,commodity_id: 1,quantity: 200,
                                     project_id: 1,unit_of_measure_id: 1,receive_id:  'test',receive_item_id:  'test'}
                                   ]}
                                 }
    end

    assert_redirected_to receipts_url
  end



  test "should get edit" do
    get edit_receipt_url('en',@receipt)
    assert_response :success
  end


  test "should update receipt" do
    patch receipt_url('en', @receipt), params: { receipt: { received_date: '2017-01-01',
                                                  receipt_lines: [{commodity_category_id: 1,commodity_id: 1,quantity: 200,
                                                  project_id: 1,unit_of_measure_id: 1,receive_id:  'test',receive_item_id:  'test'}
                                                ]}
                                              }
    assert_response :success

   end


  test "receipt donor id must not be nil" do   
     new_receipt = Receipt.new(grn_no: '12345',draft: true,commodity_source_id: 1)     
     assert !new_receipt.valid?
     assert_equal [" is required!"], new_receipt.errors.messages[:donor_id]
  end



end