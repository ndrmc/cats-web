require 'test_helper'

class RoleTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @role_type = role_types(:one)
  end

  test "should get index" do
    get role_types_url
    assert_response :success
  end

  test "should get new" do
    get new_role_type_url
    assert_response :success
  end

  test "should create role_type" do
    assert_difference('RoleType.count') do
      post role_types_url, params: { role_type: { description: @role_type.description, name: @role_type.name } }
    end

    assert_redirected_to role_type_url(RoleType.last)
  end

  test "should show role_type" do
    get role_type_url(@role_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_role_type_url(@role_type)
    assert_response :success
  end

  test "should update role_type" do
    patch role_type_url(@role_type), params: { role_type: { description: @role_type.description, name: @role_type.name } }
    assert_redirected_to role_type_url(@role_type)
  end

  test "should destroy role_type" do
    assert_difference('RoleType.count', -1) do
      delete role_type_url(@role_type)
    end

    assert_redirected_to role_types_url
  end
end
