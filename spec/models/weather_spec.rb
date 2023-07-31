# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Weather, type: :model do
  let(:weather) { FactoryBot.build(:weather) }

  describe 'validations' do
    it 'validates address' do
      weather.address = nil

      expect(weather).not_to be_valid
    end

    it 'validates forecast' do
      weather.forecast = nil

      expect(weather).to be_valid
    end
  end

  context 'when setting address with hash' do
    it 'sets address' do
      weather = described_class.new address: FactoryBot.build(:address).attributes

      address = weather.address

      expect(address).to be_a Address
    end
  end

  context 'when setting address with object' do
    it 'sets address' do
      weather = described_class.new address: FactoryBot.build(:address)

      address = weather.address

      expect(address).to be_a Address
    end
  end

  describe '#fetch' do
    let(:body) { FactoryBot.build(:open_meteo).to_json }
    let(:client) { instance_double(Faraday::Connection, get: faraday_response) }
    let(:faraday_response) { instance_double(Faraday::Response, body:) }

    before do
      allow(Faraday).to receive(:new) { client }
      allow(client).to receive(:get) { faraday_response }
      allow(faraday_response).to receive(:success?).and_return(true)
      allow(faraday_response).to receive(:body) { FactoryBot.build(:open_meteo) }

      stub_request(:get, %r{https://api.opencagedata.com/geocode/v1/json})
        .to_return(status: 200, body: FactoryBot.build(:opencage).to_json)
    end

    it 'returns forecast weather' do
      forecast = weather.fetch.forecast

      expect(forecast.count).to eq 6
    end

    it 'returns current temp' do
      current_temp = weather.fetch.current_temp

      expect(current_temp).to eq 58.6
    end

    it 'returns high temp' do
      high_temp = weather.fetch.high_temp

      expect(high_temp).to eq 73.4
    end

    it 'returns low temp' do
      low_temp = weather.fetch.low_temp

      expect(low_temp).to eq 52.4
    end
  end
end
