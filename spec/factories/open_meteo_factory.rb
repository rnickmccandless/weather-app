# frozen_string_literal: true

FactoryBot.define do
  factory :open_meteo, class: Hash do
    latitude { 37.763283 }
    longitude { -122.41286 }
    generationtime_ms  { 0.247955322265625 }
    utc_offset_seconds { 0 }
    timezone { 'GMT' }
    timezone_abbreviation { 'GMT' }
    elevation { 8.0 }
    current_weather do
      { temperature: 58.6, windspeed: 17.8, winddirection: 278.0, weathercode: 0, is_day: 0, time: '2023-07-31T04:00' }
    end
    daily_units do
      { time: 'iso8601', temperature_2m_max: '°F', temperature_2m_min: '°F' }
    end
    daily do
      { time: %w[2023-07-31 2023-08-01 2023-08-02 2023-08-03 2023-08-04 2023-08-05 2023-08-06],
        temperature_2m_max: [73.4, 68.8, 73.1, 69.3, 78.3, 87.4, 89.7],
        temperature_2m_min: [52.4, 53.3, 54.9, 55.6, 57.6, 53.6, 54.5] }
    end

    initialize_with { attributes }
  end
end
