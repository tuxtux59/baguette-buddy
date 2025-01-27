require "test_helper"

class UnitTest < ActiveSupport::TestCase
  test "should have a valid name" do
    unit = Unit.create(name: nil, plural: "plural", abbreviation: "abbreviation")

    assert_not unit.valid?
    assert_includes(unit.errors[:name], "can't be blank")
  end
  
  test "should have a valid plural" do
    unit = Unit.create(name: "my_unit", plural: nil, abbreviation: "abbreviation")

    assert_not unit.valid?
    assert_includes(unit.errors[:plural], "can't be blank")
    
    unit2 = Unit.new(name: "my_second_unit", plural: "my_second_unit", abbreviation: "abbreviation")

    assert_not unit2.valid?
    assert_includes(unit2.errors[:plural], "can't be the same as name")
  end

  test "should have a valid abbreviation" do
    unit = Unit.create(name: "my_unit", plural: "my_second_unit", abbreviation: nil)  

    assert_not unit.valid?
    assert_includes(unit.errors[:abbreviation], "can't be blank")
  end

  test "should have valid variants" do
    unit2 = Unit.create(name: "my_second_unit", plural: "my_second_units", abbreviation: "msu", variants: ["m.s.u"])  

    assert unit2.valid?
    
    # unit2 = Unit.create(name: "my_second_unit", plural: "my_second_units", abbreviation: "msu", variants: 42)  

    # puts unit2.to_json
    # assert_not unit2.valid?
    # puts unit2.errors.to_json
    # assert_includes(unit2.errors[:variants], "can't be blank")
  end
end
