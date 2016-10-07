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
      post :create, params: { gig: {
        details: @gig.details, end_time: @gig.end_time, location: @gig.location,
        start_time: @gig.start_time, status: @gig.status, title: @gig.title,
        start_date_display: @gig.start_time.to_date,
        start_time_display: @gig.start_time.to_time,
        end_date_display: @gig.end_time.to_date,
        end_time_display: @gig.end_time.to_time,
        call_time: @gig.start_time,
        call_time_display: @gig.start_time.to_time,
        confirmation_deadline_display: @gig.confirmation_deadline.to_date,
        confirmation_deadline: @gig.confirmation_deadline } }
    end

    assert_redirected_to gigs_path
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
    patch :update, params: { id: @gig, gig: {
      details: @gig.details, end_time: @gig.end_time, location: @gig.location,
      start_time: @gig.start_time, status: @gig.status, title: @gig.title,
      start_date_display: @gig.start_time.to_date,
      start_time_display: @gig.start_time.to_time,
      end_date_display: @gig.end_time.to_date,
      end_time_display: @gig.end_time.to_time,
      call_time: @gig.start_time,
      call_time_display: @gig.start_time.to_time,
      confirmation_deadline_display: @gig.confirmation_deadline.to_date,
      confirmation_deadline: @gig.confirmation_deadline } }
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
