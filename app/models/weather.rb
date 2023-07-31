# frozen_string_literal: true

class Weather
  require 'geokit'

  include ActiveModel::API
  include ActiveModel::Attributes

  attribute :address, AddressType.new
  attribute :forecast

  attr_accessor :unit, :current_temp, :high_temp, :low_temp, :forecast

  validates :address, presence: true

  def self.find(address)
    new(address:).fetch
  end

  def fetch
    Rails.cache.fetch("#{address}/address", expires_in: 30.minutes) do
      weather_service_from(address.to_s)
    end

    self
  end

  private

  def weather_service_from(address)
    weather_service = WeatherService.new(address).fetch

    if weather_service.errors.any?
      weather_service.errors.each { |err| errors.add(:address, err) }

      return nil
    end

    assign_attributes weather_attributes(weather_service)
  end

  def weather_attributes(weather_service)
    {
      unit: weather_service.temperature_unit,
      current_temp: weather_service.weather[:current_weather][:temperature],
      high_temp: weather_service.weather[:daily][:temperature_2m_max].first,
      low_temp: weather_service.weather[:daily][:temperature_2m_min].first,
      forecast: structure_forecast(weather_service.weather[:daily])
    }
  end

  def structure_forecast(forecast)
    forecast[:time][1..].map.with_index do |time, i|
      {
        time:,
        min: forecast[:temperature_2m_min][i],
        max: forecast[:temperature_2m_max][i]
      }
    end
  end
end
