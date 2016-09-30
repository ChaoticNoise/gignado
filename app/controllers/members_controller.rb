class MembersController < ApplicationController

  helper_method :member

  # GET /members
  def index
    @form = MemberQueryForm.new(Member::IndexQuery.new)
    @members = Member.order(:first_name)
  end

  def query
    @members = Member::IndexQuery.new(params[:member_query]).members
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
end
