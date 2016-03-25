require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    get :home
    assert_response :success
  end

  test "should get profile" do
    get :profile
    assert_response :success
  end

  test "should get explore" do
    get :explore
    assert_response :success
  end

  test "should get manuscript" do
    get :manuscript
    assert_response :success
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get search" do
    get :search
    assert_response :success
  end

  test "should get newsfeed" do
    get :newsfeed
    assert_response :success
  end

end
