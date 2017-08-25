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
        url: @promotion.url, location_url: @promotion.location_url,
        details: @promotion.details, end_time: @promotion.end_time, location_display: @promotion.location_display,
        start_time: @promotion.start_time, title: @promotion.title,
        start_date_display: @promotion.start_time.to_date,
        start_time_display: @promotion.start_time.to_time,
        end_date_display: @promotion.end_time.to_date,
        end_time_display: @promotion.end_time.to_time } }
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
      details: @promotion.details, end_time: @promotion.end_time, location_display: @promotion.location_display,
      start_time: @promotion.start_time, title: @promotion.title,
      start_date_display: @promotion.start_time.to_date,
      start_time_display: @promotion.start_time.to_time,
      end_date_display: @promotion.end_time.to_date,
      end_time_display: @promotion.end_time.to_time } }
    assert_redirected_to gigs_path
  end

end
