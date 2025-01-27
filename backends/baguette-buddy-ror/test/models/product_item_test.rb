require "test_helper"

class ProductItemTest < ActiveSupport::TestCase
  test "should have a name" do
    product_item = ProductItem.new(name: nil)

    assert_not product_item.valid?
    assert_includes(product_item.errors[:name], "can't be blank")
  end
  
  test "should have a references to unit" do
    product_item = ProductItem.new(name: "Salt", unit: nil)

    assert_not product_item.valid?
    assert_includes(product_item.errors[:unit], "must exist")
  end

  test "can have a references to unit" do
    unit = Unit.create!(name: "Kilogram", plural: "Kilograms", abbreviation: "kg")
    product_item = ProductItem.new(name: "Salt", unit: unit)

    assert product_item.valid?
    assert product_item.unit == unit
  end
end
