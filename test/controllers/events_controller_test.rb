require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include ActiveJob::TestHelper

  setup do
    @event = FactoryGirl.create(:gig) # creating a gig here cause there are no routes for event stuff yet (oether than index)
    sign_in FactoryGirl.create(:member)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get index as calendar" do
    get :index, format: :ics
    assert_response :success
    assert_not_nil assigns(:events)
    assert_match(/#{CGI::escapeHTML(@event.title)}/, response.body)
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, params: { id: @event }
    end

    assert_redirected_to events_path
  end

  test "should enqueue EventsSyncJob" do
    assert_enqueued_with(job: EventsSyncJob) do
      get :sync
    end

    assert_enqueued_jobs 1
    assert_response :success
  end

  test "should not enqueue EventsSyncJob" do
    get :sync, params: { job_id: 'foo'}
    assert_no_enqueued_jobs
    assert_response :success
  end

  test "should get async grid" do
    get :async_grid, xhr: true, format: 'js'
    assert_response :success
    assert_not_nil assigns(:events)
  end
end
