class FriendshipsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      friend = User.find(params[:friend_id])
      friendship = current_user.friendships.build(friend: friend, status: 'pending')
      if friendship.save
        render json: { message: 'Friend request sent.' }, status: :ok
      else
        render json: { errors: friendship.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def update
      friendship = Friendship.find_by(id: params[:id])
      if friendship.update(status: 'accepted')
        render json: { message: 'Friend request accepted.' }, status: :ok
      else
        render json: { errors: friendship.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      friendship = Friendship.find_by(id: params[:id])
      if friendship&.destroy
        render json: { message: 'Friend removed.' }, status: :ok
      else
        render json: { errors: 'Unable to remove friend.' }, status: :unprocessable_entity
      end
    end
  end