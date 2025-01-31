class Ingredient < ApplicationRecord
  belongs_to :receipe
  belongs_to :product_item

   validates :receipe, uniqueness: { scope: :product_item }
   validates :quantity, numericality: {greater_than_or_equal_to: 1}
end
