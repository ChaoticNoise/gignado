require 'test_helper'

class PromotionFormTest < ActiveSupport::TestCase
  def setup
    @params = {
      title: 'title',
      location_display: 'location', time_display: 'time',
    }

    @form = PromotionForm.new(Promotion.new)
  end

  test "validation passes" do
    assert @form.validate(@params), "Promotion should pass validation"
  end
end
