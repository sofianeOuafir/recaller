require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def setup
    @user = User.new(username:"sofiane", email: "sofian.ouafir@live.fr", password: "helloo")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "username should not be blank" do
    @user.username = " "
    assert_not @user.valid?
  end

  test "username length should be 2 characters minimum" do
    @user.username = "a"
    assert_not @user.valid?
  end

  test "username length should be 50 characters maximum" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "username should be trimmed before validation" do
    username = " Sofiane "
    @user.username = username
    @user.save
    assert_equal username.strip, @user.username
  end

  test "username should be capitalize before save" do
    username = "sofiane"
    @user.username = username
    @user.save
    assert_equal username.capitalize, @user.username
  end
end
