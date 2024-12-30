class BlockController < ApplicationController
    before_action :authenticate_user!
  
    def create
      blocked_user = User.find(params[:blocked_id])
      block = current_user.block_relationships.build(blocked: blocked_user)
      if block.save
        render json: { message: 'User blocked.' }, status: :ok
      else
        render json: { errors: block.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    def destroy
      block = Block.find_by(blocker: current_user, blocked_id: params[:blocked_id])
      if block&.destroy
        render json: { message: 'Block removed.' }, status: :ok
      else
        render json: { errors: 'Unable to remove block.' }, status: :unprocessable_entity
      end
    end
  end