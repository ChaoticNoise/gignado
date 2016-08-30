require 'test_helper'

class MembersControllerTest < ActionController::TestCase
  include Devise::Test::ControllerHelpers

  setup do
    @member = FactoryGirl.create(:member)
    sign_in FactoryGirl.create(:member)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:members)
  end

  test "should get edit" do
    get :edit, params: { id: @member }
    assert_response :success
  end

  test "should update gig" do
    patch :update, params: { id: @member, member: { first_name: @member.first_name, last_name: @member.last_name, email: @member.email, is_active: 1 } }
    assert_redirected_to members_path
  end
end
