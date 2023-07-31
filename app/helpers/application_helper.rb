# frozen_string_literal: true

module ApplicationHelper
  def temp_with_unit(temp, unit)
    "#{temp}° #{unit.capitalize.chars.first}"
  end

  def format_date_from(date)
    Date.strptime(date).strftime('%D')
  end
end
