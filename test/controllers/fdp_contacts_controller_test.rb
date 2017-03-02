require 'test_helper'

class FdpContactsControllerTest < ActionDispatch::IntegrationTest
  setup do
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
      post fdp_contacts_url, params: { fdp_contact: { active: @fdp_contact.active, description: @fdp_contact.description, lat: @fdp_contact.lat, location_id: @fdp_contact.location_id, lon: @fdp_contact.lon, name: @fdp_contact.name } }
    end

    assert_redirected_to fdp_contact_url(FdpContact.last)
  end

  test "should show fdp_contact" do
    get fdp_contact_url(@fdp_contact)
    assert_response :success
  end

  test "should get edit" do
    get edit_fdp_contact_url(@fdp_contact)
    assert_response :success
  end

  test "should update fdp_contact" do
    patch fdp_contact_url(@fdp_contact), params: { fdp_contact: { active: @fdp_contact.active, description: @fdp_contact.description, lat: @fdp_contact.lat, location_id: @fdp_contact.location_id, lon: @fdp_contact.lon, name: @fdp_contact.name } }
    assert_redirected_to fdp_contact_url(@fdp_contact)
  end

  test "should destroy fdp_contact" do
    assert_difference('FdpContact.count', -1) do
      delete fdp_contact_url(@fdp_contact)
    end

    assert_redirected_to fdp_contacts_url
  end
end
