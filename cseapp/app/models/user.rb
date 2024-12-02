class User < ApplicationRecord
    has_secure_password
    def active?
      active
    end
    has_one :profile, dependent: :destroy
  
    validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
    validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :password, presence: true, length: { minimum: 6, maximum: 50 }, on: :create
  end
 