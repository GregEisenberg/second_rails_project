require "test_helper"

class LinksControllerTest < ActionDispatch::IntegrationTest
  # This code is executed once before each test is run
  setup do
    @link = links(:one)
  end

  test "should get index" do
    get links_url
    assert_response :success
  end

  test "should get new when not logged in, instead should redirect" do
    get new_link_url
    assert_redirected_to new_user_session_url
  end


  test "should get new_link_url when logged in" do
    user = users(:one) # user from text fixture
    sign_in user

    get new_link_url
    assert_response :success
  end

  test "should create link" do
    assert_difference("Link.count") do
      user = users(:one) # user from text fixture
      sign_in user

      post links_url, params: { link: { title: @link.title, url: @link.url, user: user } }
    end

    assert_redirected_to link_url(Link.last)
  end

  test "should show link" do
    get link_url(@link)
    assert_response :success
  end

  test "should get edit" do
    user = users(:one) # user from text fixture
    sign_in user

    get edit_link_url(@link)
    assert_response :success
  end

  test "should update link" do
    user = users(:one) # user from text fixture
    sign_in user

    patch link_url(@link), params: { link: { title: @link.title, url: @link.url, user: user } }
    assert_redirected_to link_url(@link)
  end

  test "should destroy link" do
    assert_difference("Link.count", -1) do
      user = users(:one) # user from text fixture
      sign_in user

      delete link_url(@link)
    end

    assert_redirected_to links_url
  end
end
