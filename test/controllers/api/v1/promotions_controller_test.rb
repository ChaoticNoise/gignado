require 'test_helper'

class Api::V1::PromotionsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @promotion = FactoryGirl.create(:promotion)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:promotions)
  end
end
