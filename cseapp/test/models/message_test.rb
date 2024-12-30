require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)
    @room = rooms(:one)
    @message = Message.new(body: "Test message", user: @user, room: @room)
  end

  test "should be valid with valid attributes" do
    assert @message.valid?
  end

  test "should not be valid without a body" do
    @message.body = ""
    assert_not @message.valid?
    assert_includes @message.errors[:body], "can't be blank"
  end

  test "should not be valid without a user" do
    @message.user = nil
    assert_not @message.valid?
    assert_includes @message.errors[:user], "must exist"
  end

  test "should not be valid without a room" do
    @message.room = nil
    assert_not @message.valid?
    assert_includes @message.errors[:room], "must exist"
  end

  test "should belong to a user and a room" do
    assert_equal @user, @message.user
    assert_equal @room, @message.room
  end

  test "should save valid message" do
    assert_difference('Message.count', 1) do
      @message.save
    end
  end
end
