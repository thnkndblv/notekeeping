class Note < ApplicationRecord
  belongs_to :user
  has_many :shares

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :content, presence: true
end
