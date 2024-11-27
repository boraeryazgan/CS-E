class Profile < ApplicationRecord
  belongs_to :user

  validates :bio, length: { maximum: 500 }
  validates :location, length: { maximum: 100 }
  validates :age, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 120 }
  validates :gender, inclusion: { in: %w[Erkek Kadın Diğer], message: "Geçerli bir cinsiyet seçmelisiniz" }, allow_nil: true
end