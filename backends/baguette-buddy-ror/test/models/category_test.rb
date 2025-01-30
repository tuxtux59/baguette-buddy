require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "should have a name" do
    category = Category.create(name: nil)
    
    assert_not category.valid?
    assert_includes(category.errors[:name], "can't be blank")
  end
  
  test "should have a uniq lowercased name" do
    category1 = Category.create!(name: "category")
    category2 = Category.create(name: "CAtegory")
    
    assert_not category2.valid?
    assert_includes(category2.errors[:name], "has already been taken")
  end
end
