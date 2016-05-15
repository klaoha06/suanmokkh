require 'test_helper'

class GalleryPhotosControllerTest < ActionController::TestCase
  setup do
    @gallery_photo = gallery_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gallery_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gallery_photo" do
    assert_difference('GalleryPhoto.count') do
      post :create, gallery_photo: { external_cover_img_link: @gallery_photo.external_cover_img_link }
    end

    assert_redirected_to gallery_photo_path(assigns(:gallery_photo))
  end

  test "should show gallery_photo" do
    get :show, id: @gallery_photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gallery_photo
    assert_response :success
  end

  test "should update gallery_photo" do
    patch :update, id: @gallery_photo, gallery_photo: { external_cover_img_link: @gallery_photo.external_cover_img_link }
    assert_redirected_to gallery_photo_path(assigns(:gallery_photo))
  end

  test "should destroy gallery_photo" do
    assert_difference('GalleryPhoto.count', -1) do
      delete :destroy, id: @gallery_photo
    end

    assert_redirected_to gallery_photos_path
  end
end
