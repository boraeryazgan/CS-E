require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @room = rooms(:one)
  end

  test "should get index" do
    sign_in @user
    get rooms_url
    assert_response :success
  end

  test "should create room" do
    sign_in @user
    room_params = { name: "New Room", description: "A test room description" }

    assert_difference('Room.count', 1) do
      post rooms_url, params: { room: room_params }
    end

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_match "New Room", response.body
  end
end
