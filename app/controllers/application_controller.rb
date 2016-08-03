class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_member!
  before_action :authenticate_active_member!

  protected

  def authenticate_active_member!
    redirect_to inactive_errors_path unless current_member.nil? || (current_member.is_active || Rails.env.development?)
  end
end
