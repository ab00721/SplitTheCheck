require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers
  setup do
    @restaurant = restaurants(:one)
    @vote = votes(:one)
  end

  test "should get index not logged in" do
    get restaurants_url
    assert_response :success
  end

  test "should redirect instead of get new" do
    get new_restaurant_url
    assert_redirected_to new_user_session_path
  end

  test "should redirect instead of vote history" do
    get votes_url
    assert_redirected_to new_user_session_path
  end

  test "should show restaurant not logged in" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should redirect instead of edit" do
    get edit_restaurant_url(@restaurant)
    assert_redirected_to new_user_session_path
  end

  test "should navigate to show from index not logged in" do
    get restaurants_url
    assert_response :success
    assert_select "a[href=?]", restaurant_path(@restaurant), text: "Show" do
      get restaurant_path(@restaurant)
      assert_response :success
    end
  end

  test "should navigate to back to index from show not logged in" do
    get restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Back to restaurants" do
      get restaurants_path
      assert_response :success
    end
  end

  test "should get index" do
    sign_in users(:one)
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    sign_in users(:one)
    get new_restaurant_url
    assert_response :success
  end

  test "should show vote history" do
    sign_in users(:one)
    get votes_url
    assert_response :success
  end

  test "should show restaurant" do
    sign_in users(:one)
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should navigate to new from index" do
    sign_in users(:one)
    get restaurants_url
    assert_response :success
    assert_select "a[href=?]", new_restaurant_path, text: "New restaurant" do
      get new_restaurant_path
      assert_response :success
    end
  end

  test "should navigate to show from index" do
    sign_in users(:one)
    get restaurants_url
    assert_response :success
    assert_select "a[href=?]", restaurant_path(@restaurant), text: "Show" do
      get restaurant_path(@restaurant)
      assert_response :success
    end
  end

  test "should navigate to edit from index" do
    sign_in users(:one)
    get restaurants_url
    assert_response :success
    assert_select "a[href=?]", edit_restaurant_path(@restaurant), text: "Edit" do
      get edit_restaurant_path(@restaurant)
      assert_response :success
    end
  end

  test "should navigate to back to index from new" do
    sign_in users(:one)
    get new_restaurant_url
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Back to restaurants" do
      get restaurants_path
      assert_response :success
    end
  end

  test "should navigate to back to index from show" do
    sign_in users(:one)
    get restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Back to restaurants" do
      get restaurants_path
      assert_response :success
    end
  end

  test "should navigate to edit from show" do
    sign_in users(:one)
    get restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", edit_restaurant_path(@restaurant), text: "Edit this restaurant" do
      get edit_restaurant_path(@restaurant)
      assert_response :success
    end
  end

  test "should navigate to back to index from edit" do
    sign_in users(:one)
    get edit_restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Back to restaurants" do
      get restaurants_path
      assert_response :success
    end
  end

  test "should navigate to show from edit" do
    sign_in users(:one)
    get edit_restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", restaurant_path(@restaurant), text: "Show this restaurant" do
      get restaurant_path(@restaurant)
      assert_response :success
    end
  end

end
