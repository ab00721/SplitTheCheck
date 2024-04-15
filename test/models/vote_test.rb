require "test_helper"

class VoteTest < ActiveSupport::TestCase
  setup do
    @user = User.create(email: "user1@email.com", password: "password")
    @restaurant = Restaurant.create(name: "test restaurant", location: "Test Location")
  end

  test "vote should be created" do
    vote = Vote.new(user: @user, restaurant: @restaurant, vote: true)
    assert vote.valid?
  end

  test "vote should not be created without user" do
    vote = Vote.new(restaurant: @restaurant, vote: true)
    assert_not vote.valid?
  end

  test "vote should not be created without restaurant" do
    vote = Vote.new(user: @user, vote: true)
    assert_not vote.valid?
  end

end
