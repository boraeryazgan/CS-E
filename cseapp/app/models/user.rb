class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  scope :all_except, ->(user) { where.not(id: user) }
  after_create_commit { broadcast_append_to 'users' }
  has_many :messages
  # İlişkiler
  has_many :messages

  # Validasyonlar
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, allow_nil: true
  validates :gender, inclusion: { in: %w[male female other], message: "%{value} geçerli bir cinsiyet değil." }, allow_nil: true

  has_many :friendships
  has_many :friends, through: :friendships

  
  has_many :friend_requests, foreign_key: :requestor_id, class_name: 'Friendship'
  has_many :requested_friends, through: :friend_requests, source: :requestee

  
  has_many :received_requests, foreign_key: :requestee_id, class_name: 'Friendship'
  has_many :requestors, through: :received_requests, source: :requestor
end
