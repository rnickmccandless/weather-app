class Weather
  require 'geokit'

  include ActiveModel::API
  include GeoKit::Geocoders

  # attr_accessor :address

  def self.find(params)

  end

  def coordinates_for(location)
    MultiGeocoder.geocode(location)
  end
end
