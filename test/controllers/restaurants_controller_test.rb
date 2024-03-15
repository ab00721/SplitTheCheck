require "test_helper"

class RestaurantsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @restaurant = restaurants(:one)
  end

  test "should get index" do
    get restaurants_url
    assert_response :success
  end

  test "should get new" do
    get new_restaurant_url
    assert_response :success
  end

  test "should show restaurant" do
    get restaurant_url(@restaurant)
    assert_response :success
  end

  test "should get edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
  end

  test "should destroy restaurant" do
    assert_difference("Restaurant.count", -1) do
      delete restaurant_url(@restaurant)
    end

    assert_redirected_to restaurants_url
  end

  test "should navigate to new from index" do
    get restaurants_url
    assert_response :success
    assert_select "a[href=?]", new_restaurant_path, text: "New restaurant" do
      get new_restaurant_path
      assert_response :success
    end
  end

  test "should navigate to show from index" do
    get restaurants_url
    assert_response :success
    assert_select "a[href=?]", restaurant_path(@restaurant), text: "Show" do
      get restaurant_path(@restaurant)
      assert_response :success
    end
  end

  test "should navigate to edit from index" do
    get restaurants_url
    assert_response :success
    assert_select "a[href=?]", edit_restaurant_path(@restaurant), text: "Edit" do
      get edit_restaurant_path(@restaurant)
      assert_response :success
    end
  end

  test "should navigate to back to index from new" do
    get new_restaurant_url
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Back to restaurants" do
      get restaurants_path
      assert_response :success
    end
  end

  test "should navigate to back to index from show" do
    get restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Back to restaurants" do
      get restaurants_path
      assert_response :success
    end
  end

  test "should navigate to edit from show" do
    get restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", edit_restaurant_path(@restaurant), text: "Edit this restaurant" do
      get edit_restaurant_path(@restaurant)
      assert_response :success
    end
  end

  test "should navigate to back to index from edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Back to restaurants" do
      get restaurants_path
      assert_response :success
    end
  end

  test "should navigate to show from edit" do
    get edit_restaurant_url(@restaurant)
    assert_response :success
    assert_select "a[href=?]", restaurant_path(@restaurant), text: "Show this restaurant" do
      get restaurant_path(@restaurant)
      assert_response :success
    end
  end

end
