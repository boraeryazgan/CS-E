class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: 'User'
  
    validates :status, inclusion: { in: %w[pending accepted] }
  
    #
    validate :not_blocked
  
    def not_blocked
      if user.blocked_users.include?(friend) || friend.blocked_users.include?(user)
        errors.add(:base, "Cannot add a blocked user as a friend.")
      end
    end
  end