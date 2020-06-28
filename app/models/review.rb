class Review < ApplicationRecord
  belongs_to :user
  belongs_to :movie
  validates :body, :user, :movie, presence: true, length: {maximum: 256}
end
