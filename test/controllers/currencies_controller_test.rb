require 'test_helper'

class CurrenciesControllerTest < ActionDispatch::IntegrationTest
include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:admin)
    @currency = currencies(:one)
  end

  test "should get index" do
    get currencies_url
    assert_response :success
  end

  test "should get new" do
    get new_currency_url
    assert_response :success
  end

  test "should create currency" do
    assert_difference('Currency.count') do
      post currencies_url, params: { currency: {  name: 'dollar', symbol: '$' } }
    end

    assert_redirected_to currencies_url
  end

  test "should show currency" do
    get currency_url('en',@currency)
    assert_response :success
  end

  test "should get edit" do
    get edit_currency_url('en',@currency)
    assert_response :success
  end

  test "should update currency" do
    patch currency_url('en',@currency), params: { currency: { name: 'Birr', symbol: 'B' } }
    assert_redirected_to currencies_url
  end

  test "should destroy currency" do
    assert_difference('Currency.count', -1) do
      delete currency_url('en',@currency)
    end

    assert_redirected_to currencies_url
  end

  test "name and symbole must not be unique" do
    duplicate_currency = @currency.dup
    @currency.save
    assert_not duplicate_currency.valid?
  end

  test "name and symbol must not be blank" do
    new_currency = Currency.new(name: ' ', symbol: ' ')
    assert !new_currency.valid?
  end
  
  test "name and symbol must not be nil" do
    new_currency = Currency.new(name: nil, symbol: nil)
    assert !new_currency.valid?
  end
  
  
end
