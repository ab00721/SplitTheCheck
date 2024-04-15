require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should not save user without email" do
    user = User.new(password: "password")
    assert_not user.save, "Email can't be blank"
  end

  test "should not save user without valid email" do
    user = User.new(email: "user", password: "password")
    assert_not user.save, "Email can't be invalid"
  end

  test "should not save user without password" do
    user = User.new(email: "user@email.com")
    assert_not user.save, "Password can't be blank"
  end

  test "should not save user with same email" do
    user = User.new(email: "user@email.com", password: "password")
    assert user.save, "Email saved"
    user = User.new(email: "user@email.com", password: "password")
    assert_not user.save, "Email already used"
  end

end
