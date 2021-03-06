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

    assert_redirected_to department_url(id: Department.last)
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
    assert_redirected_to department_url(id: @department.id)
  end

  test "should destroy department" do
    assert_difference('Department.count', -1) do
      delete department_url(id: @department.id)
    end

    assert_redirected_to departments_url
  end

  test "department name should be unique" do
    duplicate_name = @department.dup
    @department.save
    assert_not duplicate_name.valid?
  end

  test "department name must be present" do 
     new_department = Department.new(name: "new_deparartment")
      assert new_department.valid?
  end

  test "department name must not be blank" do 
      new_department = Department.new(name: "  ")
      assert !new_department.valid?
  end
  
  test "department name must not be nil" do 
    new_deparartment = Department.new(name: nil)
    assert !new_deparartment.valid?
  end
end
