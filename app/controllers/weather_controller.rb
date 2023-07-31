# frozen_string_literal: true

class WeatherController < ApplicationController
  def new
    @weather = Weather.new
  end

  def create
    @weather = Weather.new(address:)

    @weather.fetch

    if @weather.errors.any?
      log_errors(weather)

      flash.now[:alert] = 'There were errors attempting to retrieve the forecast. Please try again with a new address.'

      render :new
    else
      redirect_to weather_path(address: address.attributes)
    end
  end

  def show
    @weather = Weather.find(address)
  end

  private

  def address
    @address ||= Address.new(address_params)
  end

  def address_params
    params.require(:address).permit(:street, :city, :state, :zipcode, :country)
  end

  def log_errors(weather)
    weather.errors.each { |error| logger.error error }
  end
end
