require 'test_helper'

class UserSongPreferencesControllerTest < ActionController::TestCase
  setup do
    @user_song_preference = user_song_preferences(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:user_song_preferences)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user_song_preference" do
    assert_difference('UserSongPreference.count') do
      post :create, user_song_preference: {  }
    end

    assert_redirected_to user_song_preference_path(assigns(:user_song_preference))
  end

  test "should show user_song_preference" do
    get :show, id: @user_song_preference
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user_song_preference
    assert_response :success
  end

  test "should update user_song_preference" do
    patch :update, id: @user_song_preference, user_song_preference: {  }
    assert_redirected_to user_song_preference_path(assigns(:user_song_preference))
  end

  test "should destroy user_song_preference" do
    assert_difference('UserSongPreference.count', -1) do
      delete :destroy, id: @user_song_preference
    end

    assert_redirected_to user_song_preferences_path
  end
end
