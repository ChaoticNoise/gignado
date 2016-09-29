class ErrorsController < ApplicationController

  skip_before_action :authenticate_allowed_member!

  def inactive
  end
end
