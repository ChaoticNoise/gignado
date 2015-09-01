require 'test_helper'

class EventsControllerTest < ActionController::TestCase
  setup do
    @event = FactoryGirl.create(:event)
    sign_in FactoryGirl.create(:member)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:events)
  end
end
