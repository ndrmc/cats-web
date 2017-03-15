require 'test_helper'

class TransporterAddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transporter_address = transporter_addresses(:one)
  end

  test "should get index" do
    get transporter_addresses_url
    assert_response :success
  end

  test "should get new" do
    get new_transporter_address_url
    assert_response :success
  end

  test "should create transporter_address" do
    assert_difference('TransporterAddress.count') do
      post transporter_addresses_url, params: { transporter_address: { email: @transporter_address.email, phone: @transporter_address.phone, region_id: @transporter_address.region_id } }
    end

    assert_redirected_to transporter_address_url(TransporterAddress.last)
  end

  test "should show transporter_address" do
    get transporter_address_url(@transporter_address)
    assert_response :success
  end

  test "should get edit" do
    get edit_transporter_address_url(@transporter_address)
    assert_response :success
  end

  test "should update transporter_address" do
    patch transporter_address_url(@transporter_address), params: { transporter_address: { email: @transporter_address.email, phone: @transporter_address.phone, region_id: @transporter_address.region_id } }
    assert_redirected_to transporter_address_url(@transporter_address)
  end

  test "should destroy transporter_address" do
    assert_difference('TransporterAddress.count', -1) do
      delete transporter_address_url(@transporter_address)
    end

    assert_redirected_to transporter_addresses_url
  end
end
