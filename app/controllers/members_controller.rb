class MembersController < ApplicationController

  # GET /members
  def index
    @members = Member.all
  end
end
