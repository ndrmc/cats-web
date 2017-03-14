require 'test_helper'

class GiftCertificatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gift_certificate = gift_certificates(:one)
  end

  test "should get index" do
    get gift_certificates_url
    assert_response :success
  end

  test "should get new" do
    get new_gift_certificate_url
    assert_response :success
  end

  test "should create gift_certificate" do
    assert_difference('GiftCertificate.count') do
      post gift_certificates_url, params: { gift_certificate: { amount: @gift_certificate.amount, bill_of_loading: @gift_certificate.bill_of_loading, customs_declaration_no: @gift_certificate.customs_declaration_no, donor_id: @gift_certificate.donor_id, estimated_price: @gift_certificate.estimated_price, estimated_tax: @gift_certificate.estimated_tax, eta: @gift_certificate.eta, expiry_date: @gift_certificate.expiry_date, gift_date: @gift_certificate.gift_date, mode_of_transport_id: @gift_certificate.mode_of_transport_id, port_name: @gift_certificate.port_name, program_id: @gift_certificate.program_id, reference_no: @gift_certificate.reference_no, status: @gift_certificate.status, vessel: @gift_certificate.vessel } }
    end

    assert_redirected_to gift_certificate_url(GiftCertificate.last)
  end

  test "should show gift_certificate" do
    get gift_certificate_url(@gift_certificate)
    assert_response :success
  end

  test "should get edit" do
    get edit_gift_certificate_url(@gift_certificate)
    assert_response :success
  end

  test "should update gift_certificate" do
    patch gift_certificate_url(@gift_certificate), params: { gift_certificate: { amount: @gift_certificate.amount, bill_of_loading: @gift_certificate.bill_of_loading, customs_declaration_no: @gift_certificate.customs_declaration_no, donor_id: @gift_certificate.donor_id, estimated_price: @gift_certificate.estimated_price, estimated_tax: @gift_certificate.estimated_tax, eta: @gift_certificate.eta, expiry_date: @gift_certificate.expiry_date, gift_date: @gift_certificate.gift_date, mode_of_transport_id: @gift_certificate.mode_of_transport_id, port_name: @gift_certificate.port_name, program_id: @gift_certificate.program_id, reference_no: @gift_certificate.reference_no, status: @gift_certificate.status, vessel: @gift_certificate.vessel } }
    assert_redirected_to gift_certificate_url(@gift_certificate)
  end

  test "should destroy gift_certificate" do
    assert_difference('GiftCertificate.count', -1) do
      delete gift_certificate_url(@gift_certificate)
    end

    assert_redirected_to gift_certificates_url
  end
end
