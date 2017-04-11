require 'test_helper'

class DepartmentsControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers



  setup do
   sign_in users(:admin)
    @department = departments(:two)
  end

  test "should get index" do
    get departments_url
    assert_response :success
  end

  test "should get new" do
    get new_department_url
    assert_response :success
  end

  test "should create department" do
    assert_difference('Department.count') do
      post departments_url, params: { department: {name: 'new department', description: 'des'   } }
    end

    assert_redirected_to departments_url
  end

  test "should show department" do
    get departments_url
    assert_response :success
  end

  test "should get edit" do
    get edit_department_url(id: @department.id)
    assert_response :success
  end

  test "should update department" do
    patch department_url(id: @department.id), params: { department: { name:'new_deparartment', description: 'new discription'   } }
    assert_redirected_to departments_path
  end

  test "should destroy department" do
    assert_difference('Department.count', -1) do
      delete department_url(id: @department.id)
    end

    assert_redirected_to departments_url
  end
end
