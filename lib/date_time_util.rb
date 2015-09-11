module DateTimeUtil
  def to_date_time(val)
    case
    when val.is_a?(DateTime)
      val
    when val.is_a?(String)
      DateTime.parse(val)
    when val.is_a?(Time)
      val.to_datetime
    when val.is_a?(Date)
      val.to_datetime
    when val.is_a?(Hash)
      DateTime.new(*val.values)
    end
  end
end