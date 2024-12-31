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

  test "should require a user" do
    @message.user = nil
    assert_not @message.valid?
  end

  test "should require a room" do
    @message.room = nil
    assert_not @message.valid?
  end

  test "should broadcast message to room after create" do
    assert_changes 'ActionCable.server.broadcasts.count', 1 do
      @message.save
    end
  end

  test "should not create message if user is not a participant in private room" do
    private_room = rooms(:private_room)
    @message.room = private_room
    private_room.participants.clear # Simulating that the user is not a participant

    assert_no_difference 'Message.count' do
      @message.save
    end
  end

  test "should create message if user is a participant in private room" do
    private_room = rooms(:private_room)
    @message.room = private_room
    private_room.participants << @user # Simulating that the user is a participant

    assert_difference 'Message.count', 1 do
      @message.save
    end
  end
end
