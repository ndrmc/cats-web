require 'test_helper'

class AccountsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @account = accounts(:one)
  end

  test "should get index" do
    get accounts_url
    assert_response :success
  end

  test "should get new" do
    get new_account_url
    assert_response :success
  end

  test "should create account" do
    assert_difference('Account.count') do
      post accounts_url, params: { account: { name: 'Received', code: 'received', description: 'description' } }
    end

    assert_redirected_to accounts_url
  end

  test "should show account" do
    get account_url('en',@account)
    assert_response :success

  end


  test "should get edit" do
    get edit_account_url('en',@account)
    assert_response :success
  end


  test "should update account" do
    patch account_url('en', @account), params: { account: { name: 'Updated Name' } }
    assert_redirected_to accounts_url

  end

  test "should destroy account" do
    assert_difference('Account.count', -1) do
      delete account_url('en',@account)
    end

    assert_redirected_to accounts_url
  end

  test "account name must be unique" do
    duplicate_account = @account.dup
    @account.save
    assert_not duplicate_account.valid?
  end

  test "account name must be present" do 
    assert @account.valid?
  end
  
  
  test "account name must not be blank" do
    new_account = Account.new(name: " ")
    assert !new_account.valid?
  end

  test "account name must not be nil" do
     new_account = Account.new(name: nil)
    assert !new_account.valid?
  end


end
