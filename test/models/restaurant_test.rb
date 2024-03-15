require "test_helper"

class RestaurantTest < ActiveSupport::TestCase
  test "set_defaults method sets will_split and wont_split" do
    restaurant = Restaurant.new
    restaurant.set_defaults
    assert_equal 0, restaurant.will_split
    assert_equal 0, restaurant.wont_split
  end

  test "set_defaults method is called on create" do
    restaurant = Restaurant.new
    assert_nil restaurant.will_split
    assert_nil restaurant.wont_split
    restaurant = Restaurant.create
    assert_equal 0, restaurant.will_split
    assert_equal 0, restaurant.wont_split
  end

  test "search returns all when parameters are nil" do
    searched_restaurants = Restaurant.search(nil)
    assert_not_empty searched_restaurants
    assert_equal Restaurant.count, searched_restaurants.count
  end

  test "search returns restaurants when search by name" do
    restaurant = Restaurant.create(name: "Test name", location: "Test Location", will_split: 0, wont_split: 0)
    searched_restaurants = Restaurant.search("Test name")
    assert_not_empty searched_restaurants
    assert_equal 1, searched_restaurants.count
  end

  test "search returns restaurants when search by location" do
    restaurant = Restaurant.create(name: "Test name", location: "Test Location", will_split: 0, wont_split: 0)
    searched_restaurants = Restaurant.search("Test location")
    assert_not_empty searched_restaurants
    assert_equal 1, searched_restaurants.count
  end

  test "search returns restaurants by name and location if present in both" do
    restaurantOne = Restaurant.create(name: "Test", location: "Location", will_split: 0, wont_split: 0)
    restaurantTwo = Restaurant.create(name: "Name", location: "Test", will_split: 0, wont_split: 0)
    restaurantThree = Restaurant.create(name: "Name", location: "Location", will_split: 0, wont_split: 0)
    searched_restaurants = Restaurant.search("Test")
    assert_not_empty searched_restaurants
    assert_equal 2, searched_restaurants.count
  end

  test "vote increments will_split when true" do
    restaurant = Restaurant.create(name: "Test name", location: "Test Location", will_split: 0, wont_split: 0)
    assert_equal 0, restaurant.will_split
    assert_equal 0, restaurant.wont_split
    restaurant.vote(true)
    assert_equal 1, restaurant.will_split
    assert_equal 0, restaurant.wont_split
  end

  test "vote increments wont_split when false" do
    restaurant = Restaurant.create(name: "Test name", location: "Test Location", will_split: 0, wont_split: 0)
    assert_equal 0, restaurant.will_split
    assert_equal 0, restaurant.wont_split
    restaurant.vote(false)
    assert_equal 0, restaurant.will_split
    assert_equal 1, restaurant.wont_split
  end
end
