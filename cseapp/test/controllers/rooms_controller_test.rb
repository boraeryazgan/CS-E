require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  # Test öncesi işlemler
  setup do
    @user = users(:one) # Varsayılan bir kullanıcı kullanıyoruz
    sign_in @user # Kullanıcıyı oturum açmış olarak işaretliyoruz
  end

  # "index" metodunun testi
  test "should get index" do
    get rooms_url
    assert_response :success
  end

  # "show" metodunun testi
  test "should show room" do
    room = rooms(:one) # Test için bir oda alıyoruz
    get room_url(room)
    assert_response :success
  end

  # "create" metodunun testi
  test "should create room" do
    assert_difference('Room.count') do
      post rooms_url, params: { room: { name: 'New Room' } }
    end
    assert_redirected_to room_url(Room.last)
  end
end
