require 'test_helper'

class GigFormTest < ActiveSupport::TestCase
  def setup
    @params = {
      title: 'title',
      start_date_display: 'foo', start_time_display: 'bar',
      end_date_display: 'bar', end_time_display: 'biz',
      call_time_display: 'blip', confirmation_deadline_display: 'blam',
      start_time: Time.zone.now.to_s, end_time: (Time.zone.now + 1.hour).to_s,
      call_time: Time.zone.now.to_s,
      confirmation_deadline: Time.zone.now.to_s
    }

    @form = GigForm.new(Gig.new)
  end

  test "validation passes" do
    assert @form.validate(@params), "Gig should pass validation"
  end


  test "validation fails if start time is after end time" do
    @params[:end_time] = (Time.zone.now - 1.hour).to_s
    assert !@form.validate(@params), "Gig should not have a start time after end time"
  end

  test "validation fails if call time is after start time" do
    @params[:call_time] = (Time.zone.now + 1.hour).to_s
    assert !@form.validate(@params), "Gig should not have a call time after start time"
  end

  test "validation fails if confirmation deadline is after start time" do
    @params[:confirmation_deadline] = (Time.zone.now + 1.day).to_s
    assert !@form.validate(@params), "Gig should not have a confirmation deadline after start time"
  end
end
