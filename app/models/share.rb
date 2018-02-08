class Share < ApplicationRecord
  belongs_to :note
  belongs_to :user

  scope :actives, -> { where(active: true) }
  scope :shared_with, -> (user_id) { actives.where(to_user_id: user_id) }
end
