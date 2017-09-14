require 'test_helper'

class PromotionsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers
  include ActiveJob::TestHelper

  setup do
    @promotion = FactoryGirl.create(:promotion)
    sign_in FactoryGirl.create(:member)
  end

  test "should get new" do
    get :new, params: { event_id: @promotion.event_id }
    assert_response :success
  end

  test "should create promotion" do
    assert_difference('Promotion.count') do
      post :create, params: { promotion: {
        event_id: @promotion.event_id,
        time_display: "Now",
        title: @promotion.title,
        url: @promotion.url, location_url: @promotion.location_url,
        location_display: @promotion.location_display } }
    end

    assert_redirected_to gigs_path
  end

  test "should get edit" do
    get :edit, params: { id: @promotion }
    assert_response :success
  end

  test "should update promotion" do
    patch :update, params: { id: @promotion, promotion: {
      event_id: @promotion.event_id,
      time_display: "Now",
      url: @promotion.url, location_url: @promotion.location_url,
      location_display: @promotion.location_display,
      title: @promotion.title } }
    assert_redirected_to gigs_path
  end

end
