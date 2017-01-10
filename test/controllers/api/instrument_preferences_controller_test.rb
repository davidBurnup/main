require 'test_helper'

class Api::InstrumentPreferencesControllerTest < ActionController::TestCase
  setup do
    @api_instrument_preference = api_instrument_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_instrument_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_instrument_preference" do
    assert_difference('Api::InstrumentPreference.count') do
      post :create, api_instrument_preference: {  }
    end

    assert_redirected_to api_instrument_preference_path(assigns(:api_instrument_preference))
  end

  test "should show api_instrument_preference" do
    get :show, id: @api_instrument_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_instrument_preference
    assert_response :success
  end

  test "should update api_instrument_preference" do
    patch :update, id: @api_instrument_preference, api_instrument_preference: {  }
    assert_redirected_to api_instrument_preference_path(assigns(:api_instrument_preference))
  end

  test "should destroy api_instrument_preference" do
    assert_difference('Api::InstrumentPreference.count', -1) do
      delete :destroy, id: @api_instrument_preference
    end

    assert_redirected_to api_instrument_preferences_path
  end
end
