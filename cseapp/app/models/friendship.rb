class Friendship < ApplicationRecord
    belongs_to :requestor, class_name: 'User'
    belongs_to :requestee, class_name: 'User'
  
    enum status: { pending: 0, accepted: 1, rejected: 2 }
  
    validates :requestor_id, uniqueness: { scope: :requestee_id, message: "Already sent a friend request" }
  end