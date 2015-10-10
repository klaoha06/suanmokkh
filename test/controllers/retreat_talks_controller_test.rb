require 'test_helper'

class RetreatTalksControllerTest < ActionController::TestCase
  setup do
    @retreat_talk = retreat_talks(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:retreat_talks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create retreat_talk" do
    assert_difference('RetreatTalk.count') do
      post :create, retreat_talk: { code: @retreat_talk.code, name: @retreat_talk.name }
    end

    assert_redirected_to retreat_talk_path(assigns(:retreat_talk))
  end

  test "should show retreat_talk" do
    get :show, id: @retreat_talk
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @retreat_talk
    assert_response :success
  end

  test "should update retreat_talk" do
    patch :update, id: @retreat_talk, retreat_talk: { code: @retreat_talk.code, name: @retreat_talk.name }
    assert_redirected_to retreat_talk_path(assigns(:retreat_talk))
  end

  test "should destroy retreat_talk" do
    assert_difference('RetreatTalk.count', -1) do
      delete :destroy, id: @retreat_talk
    end

    assert_redirected_to retreat_talks_path
  end
end
