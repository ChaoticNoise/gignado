class ErrorsController < ApplicationController

  skip_before_action :authenticate_active_member!

  def inactive
  end
end
