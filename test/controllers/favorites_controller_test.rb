require "test_helper"

class FavoritesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @restaurant = restaurants(:one)
    @favorite = favorites(:one)
  end

  test "should redirect index when not logged in" do
    get favorites_url
    assert_redirected_to new_user_session_path
  end

  test "should get index when logged in" do
    sign_in @user
    get favorites_url
    assert_response :success
  end

  test "should redirect show when not logged in" do
    get favorite_url(@favorite)
    assert_redirected_to new_user_session_path
  end

  test "should show favorite when logged in" do
    sign_in @user
    get favorite_url(@favorite)
    assert_response :success
  end

  test "should redirect new when not logged in" do
    get new_favorite_path
    assert_redirected_to new_user_session_path
  end

  test "should get new when logged in" do
    sign_in @user
    get new_favorite_url
    assert_response :success
  end

  test "should destroy favorite when logged in" do
    sign_in @user
    assert_difference("Favorite.count", -1) do
      delete favorite_url(@favorite)
    end

    assert_redirected_to profile_show_path
  end

  test "should redirect create favorite when not logged in" do
    assert_no_difference("Favorite.count") do
      post favorites_url, params: { favorite: { restaurant_id: @favorite.restaurant_id, user_id: @favorite.user_id } }
    end

    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy favorite when not logged in" do
    assert_no_difference("Favorite.count", -1) do
      delete favorite_url(@favorite)
    end

    assert_redirected_to new_user_session_path
  end

end
