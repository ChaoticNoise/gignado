class ErrorsController < ApplicationController

  skip_before_filter :authenticate_active_member!

  def inactive
  end
end
