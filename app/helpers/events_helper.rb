module EventsHelper
  def date_range_helper(start_date, end_date)
    if start_date.to_date != end_date.to_date
      "#{start_date.strftime("%^a, %b %-d")} - #{end_date.strftime("%^a, %b %-d, %Y")}"
    else
      start_date.strftime("%^a, %b %-d, %Y")
    end
  end
end
