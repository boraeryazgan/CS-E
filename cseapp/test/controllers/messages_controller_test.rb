require 'test_helper'

class MessagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) 
    @room = rooms(:one) 
    @message_params = { message: { body: "Test message" }, room_id: @room.id }
  end

  test "should create message" do
    sign_in @user

    assert_difference('Message.count', 1) do
      post messages_url, params: @message_params
    end

    assert_response :redirect
    assert_redirected_to room_path(@room)

    message = Message.last
    assert_equal @message_params[:message][:body], message.body
    assert_equal @room.id, message.room_id
    assert_equal @user.id, message.user_id
  end

  test "should not create message without body" do
    sign_in @user
    invalid_params = { message: { body: "" }, room_id: @room.id }

    assert_no_difference('Message.count') do
      post messages_url, params: invalid_params
    end

    assert_response :unprocessable_entity
  end
end
