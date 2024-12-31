class UsersController < ApplicationController
  def add_friend
    user = User.find_by(id: params[:id])  # ID'yi parametrelerden al
  
    if user.nil?
      redirect_to users_path, alert: "User not found."
      return
    end
  
    if current_user.add_friend(user)  # Arkadaşa ekleme işlemi
      redirect_to user_path(user), notice: 'Friend added successfully!'
    else
      redirect_to user_path(user), alert: 'Failed to add friend.'
    end
  end
  def show
    @user = User.find(params[:id])
    @users = User.all_except(current_user)

    @room = Room.new
    @rooms = Room.public_rooms
    @room_name = get_name(@user, current_user)
    @single_room = Room.where(name: @room_name).first || Room.create_private_room([@user, current_user], @room_name)

    @message = Message.new
    @messages = @single_room.messages.order(created_at: :asc)
    render 'rooms/index'
  end

  private

  def get_name(user1, user2)
    user = [user1, user2].sort
    "private_#{user[0].id}_#{user[1].id}"
  end

  
end
