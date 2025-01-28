require "application_system_test_case"

class ReceipesTest < ApplicationSystemTestCase
  setup do
    @user = User.last || User.create(username: "user2", email: "user2@example.com", password: "password")
    @receipe = {
      title: "My receipe name",
      description: "Follow these instructions",
      user: @user,
      portions_number: 1,
    }
    visit login_path
    fill_in "Email", with: @user.email
    fill_in "Password", with: "password"
    click_on "Login"
  end

  test "visiting the index" do
    visit receipes_url
    assert_selector "h2", text: "Receipes"
  end

  test "should create receipe" do
    visit receipes_url

    click_on "New Receipe"
    puts @receipe

    fill_in "Description", with: @receipe[:description]
    fill_in "Portions number", with: @receipe[:portions_number]
    fill_in "Title", with: @receipe[:title]
    click_on "Save"

    assert_text "Receipe was successfully created"
    click_on "Back"
  end

  test "should update Receipe" do
    receipe = Receipe.create!(@receipe)
    visit receipe_url(receipe)
    click_on "Edit this receipe", match: :first

    fill_in "Description", with: @receipe[:description]
    fill_in "Portions number", with: @receipe[:portions_number]
    fill_in "Title", with: @receipe[:title]
    # fill_in "User", with: @receipe[:user_id]
    click_on "Save"

    assert_text "Receipe was successfully updated"
    click_on "Back"
  end

  test "should destroy Receipe" do
    receipe = Receipe.create!(@receipe)
    visit receipe_url(receipe)
    click_on "Destroy this receipe", match: :first

    assert_text "Receipe was successfully destroyed"
  end
end
