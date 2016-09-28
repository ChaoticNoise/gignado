require 'test_helper'

class GigsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include ActiveJob::TestHelper

  setup do
    @gig = FactoryGirl.create(:gig)
    sign_in FactoryGirl.create(:member)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:gigs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create gig" do
    assert_difference('Gig.count') do
      post :create, params: { gig: { details: @gig.details, end_time: @gig.end_time, location: @gig.location, start_time: @gig.start_time, status: @gig.status, title: @gig.title, confirmation_deadline: @gig.confirmation_deadline } }
    end

    assert_redirected_to gig_path(assigns(:gig))
  end

  test "should show gig" do
    get :show, params: { id: @gig }
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: { id: @gig }
    assert_response :success
  end

  test "should update gig" do
    patch :update, params: { id: @gig, gig: { details: @gig.details, end_time: @gig.end_time, location: @gig.location, start_time: @gig.start_time, status: @gig.status, title: @gig.title, confirmation_deadline: @gig.confirmation_deadline } }
    assert_redirected_to gig_path(assigns(:gig))
  end

  test "should destroy gig" do
    assert_difference('Gig.count', -1) do
      delete :destroy, params: { id: @gig }
    end

    assert_redirected_to gigs_path
  end

  test "should enqueue GigsSyncJob" do
    assert_enqueued_with(job: GigsSyncJob) do
      get :sync
    end

    assert_enqueued_jobs 1
    assert_response :success
  end

  test "should not enqueue GigsSyncJob" do
    get :sync, params: { job_id: 'foo'}
    assert_no_enqueued_jobs
    assert_response :success
  end

  test "should get async grid" do
    get :async_grid, xhr: true, format: 'js'
    assert_response :success
    assert_not_nil assigns(:gigs)
  end
end
