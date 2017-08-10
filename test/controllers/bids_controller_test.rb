require 'test_helper'

class BidsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @bid = bids(:one)
  end

  test "should get index" do
    get bids_url
    assert_response :success
  end

  test "should get new" do
    get new_bid_url
    assert_response :success
  end

  test "should create bid" do
    assert_difference('Bid.count') do
      post bids_url, params: { bid: { bid_bond_amount: @bid.bid_bond_amount, bid_number: @bid.bid_number, closing_date: @bid.closing_date, framework_tender_id: @bid.framework_tender_id, opening_date: @bid.opening_date, region_id: @bid.region_id, remark: @bid.remark, start_date: @bid.start_date, status: @bid.status } }
    end

    assert_redirected_to bids_url
  end

  test "should show bid" do
    get bid_url('en',@bid)
    assert_response :success
  end

  test "should get edit" do
    get edit_bid_url('en',@bid)
    assert_response :success
  end

  test "should update bid" do
    patch bid_url('en',@bid), params: { bid: { bid_bond_amount: @bid.bid_bond_amount, bid_number: @bid.bid_number, closing_date: @bid.closing_date, framework_tender_id: @bid.framework_tender_id, opening_date: @bid.opening_date, region_id: @bid.region_id, remark: @bid.remark, start_date: @bid.start_date, status: @bid.status } }
    assert_redirected_to bids_url
  end

  test "should destroy bid" do
    assert_difference('Bid.count', -1) do
      delete bid_url('en',@bid)
    end

    assert_redirected_to bids_url
  end
end
