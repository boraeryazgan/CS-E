require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  # Kullanıcıları ve odaları burada tanımlıyoruz
  def setup
    @user1 = users(:user1) # test/fixtures/users.yml dosyasındaki user1 kaydını kullanabilirsiniz
    @user2 = users(:user2) # test/fixtures/users.yml dosyasındaki user2 kaydını kullanabilirsiniz
    @room = rooms(:room) # test/fixtures/rooms.yml dosyasındaki room kaydını kullanabilirsiniz
    sign_in @user1 # Eğer Devise kullanıyorsanız
  end

  # GET #show
  test "should get show and assign the correct variables" do
    get user_path(@user2) # users/:id path'e GET isteği gönderiyoruz

    # @user değişkenini doğru şekilde atadık mı?
    assert_equal assigns(:user), @user2

    # @users değişkenine doğru kullanıcıları dahil ettik mi?
    assert_includes assigns(:users), @user2
    assert_not_includes assigns(:users), @user1

    # Yeni bir Room atandı mı?
    assert assigns(:room).is_a?(Room)

    # @room_name doğru şekilde atandı mı?
    assert_equal assigns(:room_name), "private_#{@user1.id}_#{@user2.id}"

    # @single_room doğru şekilde atandı mı?
    assert_equal assigns(:single_room).name, "private_#{@user1.id}_#{@user2.id}"

    # Yeni bir Message atandı mı?
    assert assigns(:message).is_a?(Message)

    # rooms/index şablonu doğru şekilde render edildi mi?
    assert_template :index
  end
end
