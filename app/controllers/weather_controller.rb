class WeatherController < ApplicationController
  def new
    @weather = Weather.new
  end

  def show
    @weather = Weather.find(weather_params)


  end

  private

  def weather_params
    params.require(:weather).permit(:address)
  end
end
