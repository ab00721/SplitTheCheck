require "test_helper"

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @comment = comments(:one)
    @restaurant = restaurants(:one)
  end

  test "should redirect instead of index" do
    get comments_url
    assert_redirected_to new_user_session_path
  end

  test "should get index when logged in" do
    sign_in users(:one)
    get comments_url
    assert_response :success
  end

  test "should show comment when logged in" do
    sign_in users(:one)
    get comment_url(@comment)
    assert_response :success
  end

  test "should show comment when not logged in" do
    get comment_url(@comment)
    assert_response :success
  end

  test "should get new when logged in" do
    sign_in users(:one)
    get new_comment_url(restaurant_id: @restaurant.id)
    assert_response :success
  end

  test "should create comment when logged in" do
    sign_in users(:one)
    assert_difference("Comment.count") do
      post comments_url, params: { comment: { content: @comment.content, restaurant_id: @comment.restaurant_id, user_id: @comment.user_id } }
    end

    assert_redirected_to comment_url(Comment.last)
  end

  test "should destroy comment when logged in" do
    sign_in users(:one)
    assert_difference("Comment.count", -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to profile_show_path
  end

  test "should redirect get new when not logged in" do
    get new_comment_url
    assert_redirected_to new_user_session_path
  end

  test "should redirect create comment when not logged in" do
    assert_no_difference("Comment.count") do
      post comments_url, params: { comment: { content: @comment.content, restaurant_id: @comment.restaurant_id, user_id: @comment.user_id } }
    end

    assert_redirected_to new_user_session_path
  end

  test "should redirect destroy comment when not logged in" do
    assert_no_difference("Comment.count", -1) do
      delete comment_url(@comment)
    end

    assert_redirected_to new_user_session_path
  end
end
