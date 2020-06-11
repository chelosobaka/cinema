class Category < ApplicationRecord
  has_and_belongs_to_many :movies
  validates :genre, uniqueness: true
end
