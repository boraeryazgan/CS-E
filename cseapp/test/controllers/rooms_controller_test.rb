require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one) # Varsayılan bir kullanıcı
    sign_in @user # Oturum açıyoruz
  end

  test "should get index" do
    get rooms_url
    assert_response :success
  end

  test "should create room" do
    assert_difference('Room.count') do
      post rooms_url, params: { room: { name: 'New Room' } }
    end
    assert_redirected_to room_url(Room.last)
  end
end
