require 'test_helper'

class Api::V1::BotsControllerTest < ActionController::TestCase

  test "should create a slack bot" do
    post :slack
    assert_response :success
  end

end
