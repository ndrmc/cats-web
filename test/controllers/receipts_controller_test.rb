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

#   test "should create receipt" do
#     assert_difference('Receipt.count') do
#       post receipts_url, params: { receipt: { grn_no: '1234' } }
#     end

#     assert_redirected_to receipts_url
#   end



  test "should get edit" do
    get edit_receipt_url('en',@receipt)
    assert_response :success
  end


#   test "should update receipt" do
#     patch receipt_url('en', @receipt), params: { receipt: { name: 'Updated Name' } }
#     assert_redirected_to receipts_url

#   end

  test "should destroy receipt" do
    assert_difference('Receipt.count', -1) do
      delete receipt_url('en',@receipt)
    end

    assert_redirected_to receipts_url
  end

 
  
#   test "receipt name must be present" do 
#     assert @receipt.valid?
#   end
  
  
#   test "receipt name must not be blank" do
#     new_receipt = Receipt.new(name: " ")
#     assert !new_receipt.valid?
#   end

#   test "receipt name must not be nil" do
#      new_receipt = Receipt.new(name: nil)
#     assert !new_receipt.valid?
#   end



end