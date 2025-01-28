require "test_helper"

class ReceipesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "user2", email: "user2@example.com", password: "password")
    @receipe =  Receipe.create!(title: "4 plates Paëlla", description: "Description", user: @user)
    post login_path, params: { user: { email: @user.email, password: "password" } }
  end

  test "should get index" do
    get receipes_url
    assert_response :success
  end

  test "should get new" do
    get new_receipe_url
    assert_response :success
  end

  test "should create receipe" do
    assert_difference("Receipe.count") do
      post receipes_url, params: { 
        receipe: { 
          description: "description",
          title: "Some receipe name",
          user_id: @user.id
        }
      }
    end

    assert_redirected_to receipe_url(Receipe.last)
  end

  test "should show receipe" do
    get receipe_url(@receipe)
    assert_response :success
  end

  test "should show receipe using receipe's slug" do
    get receipe_url(@receipe.slug)
    assert_response :success
  end

  test "should get edit" do
    get edit_receipe_url(@receipe)
    assert_response :success
  end

  test "should update receipe" do
    patch receipe_url(@receipe), params: { receipe: { description: @receipe.description, illustration: @receipe.illustration, portions_number: @receipe.portions_number, title: @receipe.title, user_id: @receipe.user_id } }
    assert_redirected_to receipe_url(@receipe)
  end

  test "should destroy receipe" do
    assert_difference("Receipe.count", -1) do
      delete receipe_url(@receipe)
    end

    assert_redirected_to receipes_url
  end
end
