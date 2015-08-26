require 'test_helper'

class GigsControllerTest < ActionController::TestCase
  setup do
    @gig = gigs(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gig" do
    assert_difference('Gig.count') do
      post :create, gig: { details: @gig.details, end_time: @gig.end_time, location: @gig.location, start_time: @gig.start_time, status: @gig.status, title: @gig.title }
    end

    assert_redirected_to gig_path(assigns(:gig))
  end

  test "should show gig" do
    get :show, id: @gig
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @gig
    assert_response :success
  end

  test "should update gig" do
    patch :update, id: @gig, gig: { details: @gig.details, end_time: @gig.end_time, location: @gig.location, start_time: @gig.start_time, status: @gig.status, title: @gig.title }
    assert_redirected_to gig_path(assigns(:gig))
  end

  test "should destroy gig" do
    assert_difference('Gig.count', -1) do
      delete :destroy, id: @gig
    end

    assert_redirected_to gigs_path
  end
end
