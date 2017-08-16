require 'test_helper'

class PermissionsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @permission = permissions(:permission1)
  end

  test "should get index" do
    get permissions_url
    assert_response :success
  end

  test "should get new" do
    get new_permission_url
    assert_response :success
  end

  test "should create permission" do
    assert_difference('Permission.count') do
      post permissions_url, params: { permission: { name: 'test HRD' } }
    end

    assert_redirected_to permission_url(Permission.last)
  end

  test "should show permission" do
    get permission_url('en',@permission)
    assert_response :success
  end

  test "should get edit" do
    get edit_permission_url('en',@permission)
    assert_response :success
  end

  test "should update permission" do
    patch permission_url('en',@permission), params: { permission: { name: 'FSCD' } }
    assert_redirected_to permission_url(@permission)
  end

  test "should destroy permission" do
    assert_difference('Permission.count', -1) do
      delete permission_url('en',@permission)
    end

    assert_redirected_to permissions_url
  end

  test "permision name must be unique" do
    duplicated_permission = @permission.dup
    @permission.save
    assert_not duplicated_permission.valid?
  end
  
  test "permission name must not be blank" do
    new_permission = Permission.new(name: ' ')
    assert !new_permission.valid?
  end

  test "permission name must not be nil" do
    new_permission = Permission.new(name: nil)
    assert !new_permission.valid?
  end
  
  
end
