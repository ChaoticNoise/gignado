require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  include Devise::TestHelpers

  setup do
    @member = FactoryGirl.create(:member)
    sign_in FactoryGirl.create(:member)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end
end
