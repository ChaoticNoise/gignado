require 'test_helper'

class RehearsalFormTest < ActiveSupport::TestCase
  def setup
    @params = {
      date: 'foo', start_time_display: 'bar', end_time_display: 'biz',
      start_time: Time.zone.now.to_s, end_time: (Time.zone.now + 1.hour).to_s,
      rehearsal_pic_id: FactoryGirl.create(:member).id
    }

    @form = RehearsalForm.new(Rehearsal.new)
  end

  test "validation passes" do
    assert @form.validate(@params), "Rehearsal should pass validation"
  end


  test "validation fails if start time is after end time" do
    @params[:end_time] = (Time.zone.now - 1.hour).to_s
    assert !@form.validate(@params), "Rehearsal should not have a start time after end time"
  end
end
