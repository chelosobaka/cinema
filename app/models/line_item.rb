class LineItem < ApplicationRecord
  belongs_to :movie
  belongs_to :favorite
end
