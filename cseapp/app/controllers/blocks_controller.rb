class BlocksController < ApplicationController
    def create
      @block = current_user.blockings.new(blocked_id: params[:user_id])
  
      if @block.save
        
        Friendship.where(requestor: current_user, requestee_id: params[:user_id])
                  .or(Friendship.where(requestor_id: params[:user_id], requestee: current_user))
                  .destroy_all
  
        redirect_to users_path, notice: 'User has been blocked.'
      else
        redirect_to users_path, alert: 'Unable to block the user.'
      end
    end
  
    def destroy
      @block = current_user.blockings.find_by(blocked_id: params[:id])
      if @block&.destroy
        redirect_to users_path, notice: 'User has been unblocked.'
      else
        redirect_to users_path, alert: 'Unable to unblock the user.'
      end
    end
  end