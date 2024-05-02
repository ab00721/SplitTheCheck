require "test_helper"

class ProfileControllerTest < ActionDispatch::IntegrationTest

  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:one)
    @restaurant = restaurants(:one)
    @favorite = favorites(:one)
    @comment = comments(:one)
  end

  test "should get show if logged in" do
    sign_in @user
    get profile_show_url
    assert_response :success
  end

  test "should get redirect show when not logged in" do
    get profile_show_url
    assert_redirected_to new_user_session_path
  end

  test "should navigate to restaurant from profile" do
    sign_in @user
    get profile_show_url
    assert_response :success
    assert_select "a[href=?]", restaurant_path(@restaurant), text: "View restaurant" do
      get restaurant_path(@restaurant)
      assert_response :success
    end
  end
end
