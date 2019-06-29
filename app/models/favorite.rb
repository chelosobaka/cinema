class Favorite < ApplicationRecord
  has_many :line_items, dependent: :destroy
  has_many :movies, through: :line_items
end
