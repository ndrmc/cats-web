require 'test_helper'

class FdpContactsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @fdp = Fdp.first
    @fdp_contact = fdp_contacts(:one)
  end

  test "should get index" do
    get fdp_contacts_url
    assert_response :success
  end

  test "should get new" do
    get new_fdp_contact_url
    assert_response :success
  end

  test "should create fdp_contact" do
    assert_difference('FdpContact.count') do
      post fdp_contacts_url, params: { fdp_contact: { full_name: 'Abebe', email: 'abebe@gmail.com', mobile: '09898765', fdp_id: @fdp.id } }
    end

    assert_redirected_to fdp_url(@fdp)
  end

  test "should show fdp_contact" do
    get fdp_contact_url('en',@fdp_contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_fdp_contact_url('en',@fdp_contact)
    assert_response :success
  end

  test "should update fdp_contact" do
    patch fdp_contact_url('en',@fdp_contact), params: { fdp_contact: { full_name: 'Abebe', email: 'abebe@gmail.com', mobile: '09898765', fdp_id: @fdp.id } }
    assert_redirected_to fdp_contacts_url
  end

  test "should destroy fdp_contact" do
    assert_difference('FdpContact.count', -1) do
      delete fdp_contact_url('en',@fdp_contact)
    end

    assert_redirected_to fdp_contacts_url
  end

  test "name , mobile no and FDP must not be blank" do
    new_fdp_contact = FdpContact.new(full_name: ' ', mobile: ' ', fdp_id:'' )
    assert !new_fdp_contact.valid?
  end
  

  test "name , mobile no and FDP must not be nil" do
    new_fdp_contact = FdpContact.new(full_name: nil, mobile: nil,fdp_id: '')
    assert !new_fdp_contact.valid?
  end

  
end
