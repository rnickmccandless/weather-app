# frozen_string_literal: true

class WeatherService
  require 'geokit'

  WEATHER_FORECAST_ENDPOINT = 'https://api.open-meteo.com/v1/forecast'
  TEMPERATURE_UNIT = 'fahrenheit'

  Geokit::Geocoders::OpencageGeocoder.key = Rails.configuration.weather.open_cage_api_key

  attr_accessor :address, :temperature_unit, :weather, :errors

  def initialize(address)
    self.address = address
    self.errors = []
    self.temperature_unit = TEMPERATURE_UNIT
  end

  def fetch
    location = Geokit::Geocoders::OpencageGeocoder.geocode address

    unless location.success?
      self.errors << 'unable to find weather in your area'

      return self
    end

    handle_response_from request_forecast_for(location.latitude, location.longitude)

    self
  end

  private

  def request_forecast_for(latitude, longitude)
    connection = Faraday.new do |f|
      f.response :logger
      f.response :json, parser_options: { symbolize_names: true }
    end

    connection.get(WEATHER_FORECAST_ENDPOINT, open_meteo_params(latitude, longitude)) do |request|
      request.headers['User-Agent'] = 'WeatherApp'
      request.headers['Content-Type'] = 'application/json'
    end
  end

  def open_meteo_params(latitude, longitude)
    {
      latitude: latitude,
      longitude: longitude,
      daily: 'temperature_2m_max,temperature_2m_min',
      timezone: 'GMT',
      current_weather: true,
      temperature_unit: temperature_unit
    }
  end

  def handle_response_from(response)
    if response.success?
      self.weather = response.body
    else
      self.errors << 'unable to connect to open-meteo'
    end
  end
end