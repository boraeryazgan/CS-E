require 'test_helper'

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) 
    @room = rooms(:one) 

  test "should get index" do
    sign_in @user 
    get rooms_url
    assert_response :success
    assert_template 'index'
  end

  test "should show room" do
    sign_in @user
    get room_url(@room)
    assert_response :success
    assert_template 'index'
  end

  test "should create room" do
    sign_in @user
    assert_difference('Room.count', 1) do
      post rooms_url, params: { room: { name: 'Test Room' } }
    end
    assert_response :redirect
  end
end
