require 'test_helper'

class UserTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)  # `users(:one)` fixture verisini kullanıyoruz.
    @valid_user = User.new(first_name: "John", last_name: "Doe", email: "john.doe@example.com", password: "password123")
  end

  test "should be valid with valid attributes" do
    assert @valid_user.valid?
  end

  test "should not be valid without first name" do
    @valid_user.first_name = nil
    assert_not @valid_user.valid?
    assert_includes @valid_user.errors[:first_name], "can't be blank"
  end

  test "should not be valid without last name" do
    @valid_user.last_name = nil
    assert_not @valid_user.valid?
    assert_includes @valid_user.errors[:last_name], "can't be blank"
  end

  test "should not be valid with age less than 0" do
    @valid_user.age = -1
    assert_not @valid_user.valid?
    assert_includes @valid_user.errors[:age], "must be greater than or equal to 0"
  end

  test "should be valid with valid age" do
    @valid_user.age = 25
    assert @valid_user.valid?
  end

  test "should not be valid with invalid gender" do
    @valid_user.gender = "invalid_gender"
    assert_not @valid_user.valid?
    assert_includes @valid_user.errors[:gender], "invalid_gender geçerli bir cinsiyet değil."
  end

  test "should be valid with gender male" do
    @valid_user.gender = "male"
    assert @valid_user.valid?
  end

  test "should create a user and broadcast to 'users'" do
    assert_changes 'ActionCable.server.broadcasts.count', 1 do
      user = User.create(first_name: "Alice", last_name: "Smith", email: "alice.smith@example.com", password: "password123")
    end
  end

  test "should have many friendships" do
    assert_respond_to @user, :friendships
  end

  test "should have many friends" do
    assert_respond_to @user, :friends
  end

  test "should have many friend requests" do
    assert_respond_to @user, :friend_requests
  end

  test "should have many received requests" do
    assert_respond_to @user, :received_requests
  end

  test "should have many requested friends" do
    assert_respond_to @user, :requested_friends
  end

  test "should have many requestors" do
    assert_respond_to @user, :requestors
  end
end
