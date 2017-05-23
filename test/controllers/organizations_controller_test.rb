require 'test_helper'

class OrganizationsControllerTest < ActionDispatch::IntegrationTest
    include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @organization = organizations(:one)
  end

  test "should get index" do
    get organizations_url
    assert_response :success
  end

  test "should get new" do
    get new_organization_url
    assert_response :success
  end

  test "should create organization" do
    assert_difference('Organization.count') do
      post organizations_url, params: { organization: { name: 'new org'  } }
    end

    assert_redirected_to organizations_url
  end

  test "should show organization" do
    get organizations_url
    assert_response :success
  end

  test "should get edit" do
    get edit_organization_url('en',@organization)
    assert_response :success
  end

  test "should update organization" do
    patch organization_url('en',@organization), params: { organization: { name: 'new org 2'  } }
    assert_redirected_to organizations_url
  end

  test "should destroy organization" do
    assert_difference('Organization.count', -1) do
      delete organization_url('en',@organization)
    end

    assert_redirected_to organizations_url
  end

  test "Organization name must be unique" do
    duplicate_organization = @organization.dup
    @organization.save
    assert_not duplicate_organization.valid?
  end

  test "Organization name must be present" do
    assert @organization.valid?
  end
  
  test "Organization name must not be blank" do 
    new_organization = Organization.new(name: ' ')
    assert !new_organization.valid?
  end
  
  test "Organization name must not be nil" do 
    new_organization = Organization.new(name: nil)
    assert !new_organization.valid?
  end

end
