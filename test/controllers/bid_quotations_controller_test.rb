require 'test_helper'

class BidQuotationsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @bid_quotation = bid_quotations(:one)
  end
=begin
  test "should get index" do
    get bid_quotations_url
    assert_response :success
  end

  test "should get new" do
    get new_bid_quotation_url
    assert_response :success
  end

  test "should create bid_quotation" do 
    assert_difference('BidQuotation.count') do
      post bid_quotations_url, params: { bid_quotation: { transporter_id: @bid_quotation.transporter_id  } }
    end

    assert_redirected_to bid_quotation_url(BidQuotation.last)
  end

  test "should show bid_quotation" do
    get bid_quotation_url('en',@bid_quotation)
    assert_response :success
  end

  test "should get edit" do
    get edit_bid_quotation_url(@bid_quotation)
    assert_response :success
  end

  test "should update bid_quotation" do
    patch bid_quotation_url('en',@bid_quotation), params: { bid_quotation: { transporter_id: @bid_quotation.transporter_id } }
    assert_redirected_to bid_quotation_url(@bid_quotation)
  end

  test "should destroy bid_quotation" do
    assert_difference('BidQuotation.count', -1) do
      delete bid_quotation_url('en',@bid_quotation)
    end

    assert_redirected_to bid_quotations_url
  end
=end
end
