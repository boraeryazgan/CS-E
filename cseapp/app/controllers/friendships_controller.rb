class FriendshipsController < ApplicationController
    before_action :set_friend, only: [:create, :update, :destroy]
    before_action :check_block_status, only: [:create]
  
    
    def create
      friendship = current_user.friend_requests.new(requestee: @friend)
  
      if friendship.save
        redirect_to users_path, notice: 'Friend request sent.'
      else
        redirect_to users_path, alert: 'Unable to send friend request.'
      end
    end
  
   
    def update
      friendship = Friendship.find_by(requestor: @friend, requestee: current_user)
  
      if friendship.update(confirmed: true)
        redirect_to users_path, notice: 'Friend request accepted.'
      else
        redirect_to users_path, alert: 'Unable to accept friend request.'
      end
    end
  
    
    def destroy
      friendship = Friendship.find_by(requestor: @friend, requestee: current_user) || 
                   Friendship.find_by(requestor: current_user, requestee: @friend)
  
      if friendship&.destroy
        redirect_to users_path, notice: 'Friendship or request removed.'
      else
        redirect_to users_path, alert: 'Unable to remove friendship or request.'
      end
    end
  
    private
  
    
    def set_friend
      @friend = User.find(params[:user_id])
    end
  
    
    def check_block_status
      if current_user.blocked_users.include?(@friend) || current_user.blockers.include?(@friend)
        redirect_to users_path, alert: 'You cannot interact with this user.'
      end
    end
  end