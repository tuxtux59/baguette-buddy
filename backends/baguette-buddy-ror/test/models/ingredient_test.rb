  require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  test "requires product_item" do
    ingredient = Ingredient.create(product_item: nil)
    assert_not ingredient.valid?
    assert_includes(ingredient.errors[:product_item], "must exist")
  end

  test "requires receipe" do
    ingredient = Ingredient.create(receipe: nil)
    assert_not ingredient.valid?
    assert_includes(ingredient.errors[:receipe], "must exist")
  end
  test "requires positive quantity" do
    ingredient = Ingredient.create(quantity: 0)
    assert_not ingredient.valid?
    assert_includes(ingredient.errors[:quantity], "must be greater than or equal to 1")
  end
end
