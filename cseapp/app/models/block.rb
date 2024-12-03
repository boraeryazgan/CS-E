class Block < ApplicationRecord
  belongs_to :blocker, class_name: 'User'
  belongs_to :blocked, class_name: 'User'

  validates :blocked_id, uniqueness: { scope: blocked_id}
end
