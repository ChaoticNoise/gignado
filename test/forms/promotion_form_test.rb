require 'test_helper'

class PromotionFormTest < ActiveSupport::TestCase
  def setup
    @params = {
      title: 'title', start_time_display: 'bar', end_time_display: 'biz',
      location_display: 'location', time_display: 'time',
      start_time: Time.zone.now.to_s, end_time: (Time.zone.now + 1.hour).to_s
    }

    @form = PromotionForm.new(Promotion.new)
  end

  test "validation passes" do
    assert @form.validate(@params), "Promotion should pass validation"
  end


  test "validation fails if start time is after end time" do
    @params[:end_time] = (Time.zone.now - 1.hour).to_s
    assert !@form.validate(@params), "Promotion should not have a start time after end time"
  end
end
