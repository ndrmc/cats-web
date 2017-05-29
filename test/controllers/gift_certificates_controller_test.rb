require 'test_helper'

class GiftCertificatesControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
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
      post gift_certificates_url, params: { gift_certificate: { 

        reference_no: '00201' ,gift_date: '1/1/2018' ,donor_id: 1, program_id: 1,fund_type_id: 1, fund_source_id: 1, commodity_id: 1, mode_of_transport_id: 1

       } }
    end

    assert_redirected_to gift_certificates_url
  end

  test "should show gift_certificate" do
    get gift_certificates_url
    assert_response :success
  end

  test "should get edit" do
    get edit_gift_certificate_url('en',@gift_certificate)
    assert_response :success
  end

  test "should update gift_certificate" do
    patch gift_certificate_url('en',@gift_certificate), params: { gift_certificate: { 

reference_no: '0020' ,gift_date: '1/1/2018' ,donor_id: 1, program_id: 1,fund_type_id: 1, fund_source_id: 1, commodity_id: 1, mode_of_transport: 1
      
     } }
    assert_redirected_to gift_certificates_url
  end

  test "should destroy gift_certificate" do
    assert_difference('GiftCertificate.count', -1) do
      delete gift_certificate_url('en',@gift_certificate)
    end

    assert_redirected_to gift_certificates_url
  end

  test "Gift certificate mandatory fields" do 
    new_gift_certificate = GiftCertificate.new(reference_no: '0020' ,gift_date: '1/1/2018' ,donor_id: 1, program_id: 1,fund_type_id: 1, fund_source_id: 1, commodity_id: 1, mode_of_transport_id: 1)
    assert new_gift_certificate.valid?
  end

  test "Gift certificate fields are not blank" do
      new_gift_certificate = GiftCertificate.new(reference_no: ' ' ,gift_date: ' ' ,donor_id: 1, program_id: 1,fund_type_id: 1, fund_source_id: 1, commodity_id: 1, mode_of_transport_id: 1)
    assert !new_gift_certificate.valid?
  end

  test "Gift certificate fields must not be nil" do 
      new_gift_certificate = GiftCertificate.new(reference_no: nil ,gift_date: nil ,donor_id: 1, program_id: 1,fund_type_id: 1, fund_source_id: 1, commodity_id: 1, mode_of_transport_id: 1)
    assert !new_gift_certificate.valid?
  end

  test "Gift vertificate reference number must be unique" do 
    duplicate_gift_certificate = @gift_certificate.dup
    @gift_certificate.save
    assert_not duplicate_gift_certificate.valid?
  end
  
  
  
  
end
