require 'test_helper'

class DonorsControllerTest < ActionDispatch::IntegrationTest
   include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @donor = donors(:one)
  end

  test "should get index" do
    get donors_url
    assert_response :success
  end

  test "should get new" do
    get new_donor_url
    assert_response :success
  end

  test "should create donor" do
    assert_difference('Donor.count') do
      post donors_url, params: { donor: { name: 'WFP',  code: 'wf' } }
    end

    assert_redirected_to donors_url
  end

  test "should show donor" do
    get donors_url
    assert_response :success
  end

  test "should get edit" do
    get edit_donor_url('en',@donor)
    assert_response :success
  end

  test "should update donor" do
    patch donor_url('en',@donor), params: { donor: { name: 'China', code: 'ch' } }
    assert_redirected_to donors_url
  end

  test "should destroy donor" do
    assert_difference('Donor.count', -1) do
      delete donor_url('en',@donor)
    end

    assert_redirected_to donors_url
  end

  test "Donor name and code must be present" do
    assert @donor.valid?
  end

  test "Donor name and code must not be blank" do 
    new_donor = Donor.new(name: ' ', code: ' ')
    assert !new_donor.valid?
  end

  test "Donor name and code must not be nil" do
     new_donor = Donor.new(name: nil, code: nil)
    assert !new_donor.valid?
  end

  test "Donor name and code must be unique" do
    duplicate_donor = @donor.dup
    @donor.save
    assert_not duplicate_donor.valid?
  end
  
  
  
  
end
