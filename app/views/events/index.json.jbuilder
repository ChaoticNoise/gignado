json.array!(@events) do |event|
  json.extract! event, :id, :title, :status, :start_time, :end_time, :location, :details

  if event.is_a? Gig
    json.url gig_url(event, format: :json)
  end
end
