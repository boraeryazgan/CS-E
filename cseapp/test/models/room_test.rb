require 'test_helper'

class RoomTest < ActiveSupport::TestCase
  setup do
    @user1 = users(:one)
    @user2 = users(:two)
    @public_room = rooms(:public_room)
    @private_room_name = "Private Room Test"
  end

  test "should be valid with a unique name" do
    room = Room.new(name: "Unique Room", is_private: false)
    assert room.valid?
  end

  test "should not be valid with a duplicate name" do
    room = Room.new(name: @public_room.name, is_private: false)
    assert_not room.valid?
    assert_includes room.errors[:name], "has already been taken"
  end

  test "should create private room with users" do
    private_room = Room.create_private_room([@user1, @user2], @private_room_name)
    
    assert private_room.valid?
    assert private_room.is_private
    assert_equal @private_room_name, private_room.name
    assert_equal 2, private_room.participants.count
    assert private_room.participants.any? { |p| p.user_id == @user1.id }
    assert private_room.participants.any? { |p| p.user_id == @user2.id }
  end

  test "should have many messages" do
    room = rooms(:one)
    assert_respond_to room, :messages
  end

  test "should have many participants" do
    room = rooms(:one)
    assert_respond_to room, :participants
  end

  test "should broadcast to 'rooms' when created and public" do
    assert_changes 'ActionCable.server.broadcasts.count', 1 do
      room = Room.create(name: "New Public Room", is_private: false)
    end
  end

  test "should not broadcast when private" do
    assert_no_changes 'ActionCable.server.broadcasts.count' do
      room = Room.create(name: "New Private Room", is_private: true)
    end
  end
end
