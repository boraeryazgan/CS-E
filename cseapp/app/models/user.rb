class User < ApplicationRecord
    has_secure_password
  
    has_one :profile, dependent: :destroy
  
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6, maximum: 50 }, on: :create
    
    has_many :friendships
    has_many :friends, through: :friendships, source: :friend
    has_many :inverse_friendships, class_name: "Friendship", foreign_key: "friend_id"
    has_many :inverse_friends, through: :inverse_friendships, source: :user

    
    has_many :block_relationships, class_name: "Block", foreign_key: "blocker_id"
    has_many :blocked_users, through: :block_relationships, source: :blocked

    
    has_many :blocked_by_relationships, class_name: "Block", foreign_key: "blocked_id"
    has_many :blockers, through: :blocked_by_relationships, source: :blocker
  end
