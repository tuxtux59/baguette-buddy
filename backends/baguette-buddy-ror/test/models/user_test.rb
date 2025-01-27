require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "should a valid username" do
    user = User.create(username: nil, email: 'example@example.com', password_digest: 'hashed_password')
    assert_not user.valid?
    assert_includes(user.errors[:username], "can't be blank")
  end

  test "should have a unique username" do
    user1 = User.create!(username: 'existing_username', email: 'example1@example.com', password_digest: 'hashed_password')
    user2 = User.create(username: 'existing_username', email: 'example2@example.com', password_digest: 'hashed_password')

    assert_not user2.valid?
    assert_includes(user2.errors[:username], "has already been taken")
  end

  test "should have a valid email" do
    user = User.create(username: 'new_username', email: nil, password_digest: 'hashed_password')
    assert_not user.valid?
    assert_includes(user.errors[:email], "can't be blank")

    user2 = User.create(username: 'new_username', email: 'no_an_email', password_digest: 'hashed_password')
    assert_not user2.valid?

    assert_includes(user2.errors[:email], "is invalid")
  end

  test "should have a unique email" do
    user1 = User.create!(username: 'new_username', email: 'john@example.com', password_digest: 'hashed_password')
    user2 = User.create(username: 'another_username', email: 'john@example.com', password_digest: 'hashed_password')

    assert_not user2.valid?
    assert_includes(user2.errors[:email], "has already been taken")
  end

  test "should have a valid role" do
    user = User.create(username: 'new_username', email: 'example3@example.com', password_digest: 'hashed_password', role: nil)
    assert_not user.valid?
    assert_includes(user.errors[:role], "can't be blank")
  end
end
