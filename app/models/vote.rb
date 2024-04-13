class Vote < ApplicationRecord
  belongs_to :user
  belongs_to :restaurant

  validates :user_id, uniqueness: { scope: :restaurant_id, message: "already voted for this location."  }
end
