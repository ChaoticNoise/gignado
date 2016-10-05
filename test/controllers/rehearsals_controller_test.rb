require 'test_helper'

class RehearsalsControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @rehearsal = FactoryGirl.create(:rehearsal)
    sign_in FactoryGirl.create(:member)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rehearsals)
  end

  test "should get new" do
    get :new
    assert_response :success
    assert_not_nil assigns(:form)
  end

  test "should create rehearsal" do
    assert_difference('Rehearsal.count') do
      post :create, params: {
        rehearsal: {
          details: @rehearsal.details, end_time: @rehearsal.end_time,
          location: @rehearsal.location, start_time: @rehearsal.start_time,
          title: @rehearsal.title, status: @rehearsal.status,
          start_time_display: 'bar',
          end_time_display: 'biz',
          date: 'foo',
          rehearsal_pic_id: @rehearsal.rehearsal_pic.id
        } }
    end

    assert_redirected_to rehearsals_path
  end

  test "should show rehearsal" do
    get :show, params: { id: @rehearsal }
    assert_response :success
  end

  test "should get rehearsal" do
    get :edit, params: { id: @rehearsal }
    assert_response :success
  end

  test "should update rehearsal" do
    patch :update, params: {
      id: @rehearsal,
      rehearsal: {
        details: @rehearsal.details, end_time: @rehearsal.end_time,
        location: @rehearsal.location, start_time: @rehearsal.start_time,
        title: @rehearsal.title, status: @rehearsal.status,
        start_time_display: 'bar',
        end_time_display: 'biz',
        date: 'foo',
        rehearsal_pic_id: @rehearsal.rehearsal_pic.id
      } }
    assert_redirected_to rehearsals_path
  end
end
