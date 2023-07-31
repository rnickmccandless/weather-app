# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Lookup weather', type: :system do
  it 'shows modal' do
    visit root_path

    click_on 'VIEW MY WEATHER'

    expect(page).to have_content 'Weather Forecast'
  end

  it 'closes modal' do
    visit root_path

    click_on 'VIEW MY WEATHER'

    click_on 'Close'

    expect(page).not_to have_content 'Weather Forecast'
  end

  context 'when address lookup is successful' do
    let(:address) { FactoryBot.build(:address) }

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

    it 'returns the weather' do
      visit root_path

      click_on 'VIEW MY WEATHER'

      fill_in 'Street', with: address.street
      fill_in 'City', with: address.city
      select 'California', from: 'State'
      fill_in 'Zip code', with: address.zipcode
      fill_in 'Country', with: address.country

      click_on "What's my forecast?"

      expect(page).to have_content "Weather forecast for: #{address}"
      expect(page).to have_content(/Current Temperature\n58.6° F/)
      expect(page).to have_content(/High\n73.4° F/)
      expect(page).to have_content(/Low\n52.4° F/)
      expect(page).to have_content(%r{Forecast\n08/01/23\nLow\n52.4° F})
    end
  end

  context 'when address is invalid' do
    let(:address) { FactoryBot.build(:address) }

    before do
      stub_request(:get, %r{https://api.opencagedata.com/geocode/v1/json})
        .to_return(status: 500, body: FactoryBot.build(:opencage).to_json)
    end

    it 'returns an error message' do
      visit root_path

      click_on 'VIEW MY WEATHER'

      fill_in 'Street', with: address.street
      fill_in 'City', with: address.city
      select 'California', from: 'State'
      fill_in 'Zip code', with: address.zipcode
      fill_in 'Country', with: address.country

      click_on "What's my forecast?"

      expect(page).not_to have_content "Weather forecast for: #{address}"
      expect(page).not_to have_content('Current Temperature')
      expect(page).to have_content('There were errors attempting to retrieve the forecast.')
    end
  end

  context 'when the weather request fails' do
    let(:address) { FactoryBot.build(:address) }

    let(:client) { instance_double(Faraday::Connection, get: faraday_response) }
    let(:faraday_response) { instance_double(Faraday::Response) }

    before do
      allow(Faraday).to receive(:new) { client }
      allow(client).to receive(:get) { faraday_response }
      allow(faraday_response).to receive(:success?).and_return(false)

      stub_request(:get, %r{https://api.opencagedata.com/geocode/v1/json})
        .to_return(status: 200, body: FactoryBot.build(:opencage).to_json)
    end

    it 'returns an error message' do
      visit root_path

      click_on 'VIEW MY WEATHER'

      fill_in 'Street', with: address.street
      fill_in 'City', with: address.city
      select 'California', from: 'State'
      fill_in 'Zip code', with: address.zipcode
      fill_in 'Country', with: address.country

      click_on "What's my forecast?"

      expect(page).not_to have_content "Weather forecast for: #{address}"
      expect(page).not_to have_content('Current Temperature')
      expect(page).to have_content('There were errors attempting to retrieve the forecast.')
    end
  end
end
