require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    sign_in users(:admin)
    @user = users(:admin)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should show user" do
    get users_url('en',@user)
    assert_response :success
  end

  test "should get edit" do
    get edit_user_url('en',@user)
    assert_response :success
  end

  test "should update user" do
    patch user_url('en',@user), params: { user: { 

            first_name: 'Admin',
            last_name: '',
            email: 'admin@cats.org',
            is_active: true,
            passowrd: 'password',
           user_types: :manager
     } }
    assert_redirected_to users_url
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url('en',@user)
    end

    assert_redirected_to users_url
  end

 
end