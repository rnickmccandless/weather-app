# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address, type: :model do
  let(:address) { FactoryBot.build(:address) }

  describe 'validations' do
    it 'validates street' do
      address.street = nil

      expect(address).not_to be_valid
    end

    it 'validates city' do
      address.city = nil

      expect(address).not_to be_valid
    end

    it 'validates state' do
      address.state = nil

      expect(address).not_to be_valid
    end

    it 'validates zipcode' do
      address.zipcode = nil

      expect(address).not_to be_valid
    end

    it 'validates country' do
      address.country = nil

      expect(address).not_to be_valid
    end
  end

  describe '#to_s' do
    it 'returns full address string' do
      result = address.to_s

      expect(result).to eq '140 Market St, San Francisco, CA, 94105, United States'
    end
  end
end
