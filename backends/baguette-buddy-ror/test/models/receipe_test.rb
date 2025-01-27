require "test_helper"

class ReceipeTest < ActiveSupport::TestCase
  test "should have a title" do
    receipe = Receipe.create(title: nil, description: "Description")
    assert_not receipe.valid?
    assert_includes(receipe.errors[:title], "can't be blank")
  end

  test "should have a description" do
    receipe = Receipe.create(title: "title", description: nil)
    assert_not receipe.valid?
    assert_includes(receipe.errors[:description], "can't be blank")
  end

  test "should have a positive portions_number" do
    receipe = Receipe.create(title: "title", description: "Description", portions_number: -1)
    assert_not receipe.valid?
    assert_includes(receipe.errors[:portions_number], "must be greater than or equal to 1")
  end
  
  test "should have a user" do
    receipe = Receipe.create(title: "title", description: "Description")
    assert_not receipe.valid?
    assert_includes(receipe.errors[:user], "must exist")
  end
  
  test "should have a unique title" do
    user = User.create(username: "user", email: "user@example.com", password_digest: "hashed")
    receipe1 = Receipe.create!(title: "title1", description: "Description", user: user)
    receipe2 = Receipe.create(title: "title1", description: "Description", user: user)
    
    assert_not receipe2.valid?
    assert_includes(receipe2.errors[:title], "has already been taken")
  end
end
