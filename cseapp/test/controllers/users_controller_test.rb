require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get users_show_url
    assert_response :success
  end
end
# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:room) { create(:room, name: "private_#{user1.id}_#{user2.id}") }

  describe 'GET #show' do
    before do
      sign_in user1 # Eğer Devise kullanıyorsanız
      allow(Room).to receive(:public_rooms).and_return([room])
      get :show, params: { id: user2.id }
    end

    it 'assigns the requested user to @user' do
      expect(assigns(:user)).to eq(user2)
    end

    it 'assigns all users except current_user to @users' do
      expect(assigns(:users)).to include(user2)
      expect(assigns(:users)).not_to include(user1)
    end

    it 'assigns a new Room to @room' do
      expect(assigns(:room)).to be_a_new(Room)
    end

    it 'assigns the correct room name to @room_name' do
      expect(assigns(:room_name)).to eq("private_#{user1.id}_#{user2.id}")
    end

    it 'assigns the private room to @single_room' do
      expect(assigns(:single_room).name).to eq("private_#{user1.id}_#{user2.id}")
    end

    it 'assigns a new Message to @message' do
      expect(assigns(:message)).to be_a_new(Message)
    end

    it 'renders the rooms/index template' do
      expect(response).to render_template('rooms/index')
    end
  end
end
