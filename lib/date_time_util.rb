module DateTimeUtil
  def to_date_time(val)
    if val.blank?
      return
    elsif val.is_a?(DateTime)
      val
    elsif val.is_a?(String)
      DateTime.parse(val)
    elsif val.is_a?(Time)
      val.to_datetime
    elsif val.is_a?(Date)
      val.to_datetime
    elsif val.is_a?(Hash)
      DateTime.new(*val.values)
    end
  end
end
