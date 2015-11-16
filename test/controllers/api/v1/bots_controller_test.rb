require 'test_helper'

class Api::V1::BotsControllerTest < ActionController::TestCase

  test "should get show" do
    get :show, id: 'slack'
    assert_response :success
  end
  
end
