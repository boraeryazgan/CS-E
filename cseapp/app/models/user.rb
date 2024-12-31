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

  # Arkadaş ekleme
  def add_friend(friend_id)
    friend = User.find(friend_id.id)
    self.friends ||= []
    self.blocked_users ||= []

    # Aynı kişi, zaten arkadaş ya da engellenmişse ekleme
    return false if self == friend || self.friends.include?(friend.first_name.to_s) || self.blocked_users.include?(friend.id.to_s)

    # Arkadaşı listeye ekle
    self.friends << friend.id.to_s
    save
  end

  # Engellenen kullanıcı ekleme
  def block_user(user)
    self.blocked_users << user.id unless self.blocked_users.include?(user.id)
    save
  end

  # Arkadaş silme
  def remove_friend(user)
    self.friends.delete(user.id)
    save
  end

  # Engellenen kullanıcıyı kaldırma
  def unblock_user(user)
    self.blocked_users.delete(user.id)
    save
  end

  # Arkadaşları alma
  def get_friends
    User.where(id: self.friends)
  end

  # Engellenen kullanıcıları alma
  def get_blocked_users
    User.where(id: self.blocked_users)
  end
end
