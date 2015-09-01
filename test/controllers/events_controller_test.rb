require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  include Devise::TestHelpers

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
end
