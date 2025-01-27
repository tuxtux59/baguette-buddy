require "test_helper"

class IngredientTest < ActiveSupport::TestCase
  test "should have a name" do
    ingredient = Ingredient.new(name: nil)

    assert_not ingredient.valid?
    assert_includes(ingredient.errors[:name], "can't be blank")
  end
  
  test "should have a references to unit" do
    ingredient = Ingredient.new(name: "Salt", unit: nil)

    assert_not ingredient.valid?
    assert_includes(ingredient.errors[:unit], "must exist")
  end

  test "can have a references to unit" do
    unit = Unit.create!(name: "Kilogram", plural: "Kilograms", abbreviation: "kg")
    ingredient = Ingredient.new(name: "Salt", unit: unit)

    assert ingredient.valid?
    assert ingredient.unit == unit
  end
end
