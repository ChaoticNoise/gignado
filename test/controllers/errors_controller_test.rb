require 'test_helper'

class ErrorsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  test "should redirect_to errors#inactive" do
    sign_in FactoryGirl.create(:member, activated_at: nil)
    @controller = EventsController.new
    get :index
    assert_redirected_to inactive_errors_path
  end
end
