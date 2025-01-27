class Ingredient < ApplicationRecord
  belongs_to :unit

  validates  :name, presence: true
  validates  :unit, presence: true
end
