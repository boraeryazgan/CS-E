require 'test_helper'

class ParticipantTest < ActiveSupport::TestCase
  setup do
    @user = users(:one)    # `users(:one)` fixture verisini kullanıyoruz.
    @room = rooms(:one)    # `rooms(:one)` fixture verisini kullanıyoruz.
    @participant = Participant.new(user: @user, room: @room)
  end

  test "should be valid with valid user and room" do
    assert @participant.valid?
  end

  test "should require a user" do
    @participant.user = nil
    assert_not @participant.valid?
  end

  test "should require a room" do
    @participant.room = nil
    assert_not @participant.valid?
  end

  test "should not allow duplicate user-room pair" do
    # Önce bir katılımcı kaydediyoruz.
    @participant.save
    duplicate_participant = Participant.new(user: @user, room: @room)
    
    # Aynı kullanıcı ve oda kombinasyonuyla bir başka katılımcı kaydetmeye çalışıyoruz.
    assert_not duplicate_participant.valid?
    assert_includes duplicate_participant.errors[:user_id], "has already been taken"
  end
end
