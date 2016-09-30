class MembersController < ApplicationController

  helper_method :member, :members, :query_form

  # GET /members
  def index
  end

  def query
    respond_to do |format|
      format.js
    end
  end

  # GET /members/1/edit
  def edit
    @form = MemberForm.new(member)
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    @form = MemberForm.new(member)

    if @form.validate(params[:member])
      @form.save
      redirect_to members_url, notice: 'Member was successfully updated.'
    else
      render :edit
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def member
    @member ||= Member.find(params[:id])
  end

  def query_form
    @query_form ||= MemberQueryForm.new(Member::IndexQuery.new)
  end

  def members
    query_form.validate(params[:member_query] || { trial: "1", active: "1" })
    query_form.sync
    query_form.model.members.order(:first_name)
  end
end
