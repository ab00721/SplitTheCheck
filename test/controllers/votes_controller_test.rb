require "test_helper"

class VotesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @vote = votes(:one)
  end

  test "should redirect instead of index" do
    get votes_url
    assert_redirected_to new_user_session_path
  end

  test "should redirect instead of show" do
    get vote_url(@vote)
    assert_redirected_to new_user_session_path
  end

  test "should show vote" do
    sign_in users(:one)
    get vote_url(@vote)
    assert_response :success
  end

  test "should get edit" do
    sign_in users(:one)
    get edit_vote_url(@vote)
    assert_response :success
  end

  test "should update vote" do
    sign_in users(:one)
    patch vote_url(@vote), params: { vote: { restaurant_id: @vote.restaurant_id, user_id: @vote.user_id, vote: @vote.vote } }
    assert_redirected_to vote_url(@vote)
  end

  test "should destroy vote" do
    sign_in users(:one)
    assert_difference("Vote.count", -1) do
      delete vote_url(@vote)
    end

    assert_redirected_to votes_url
  end

  test "should navigate to restaurants from votes" do
    sign_in users(:one)
    get votes_url
    assert_response :success
    assert_select "a[href=?]", restaurants_path, text: "Home" do
      get restaurants_path
      assert_response :success
    end
  end

end
