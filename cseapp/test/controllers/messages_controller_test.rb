require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) 
    @room = rooms(:one) 
  end

  test "should create message" do
    sign_in @user 
    message_body = "Hello, this is a test message!"

    assert_difference('Message.count', 1) do
      post room_messages_path(@room), params: { message: { body: message_body } }
    end

    assert_response :success
    created_message = Message.last
    assert_equal message_body, created_message.body
    assert_equal @room.id, created_message.room_id
    assert_equal @user.id, created_message.user_id
  end
end
