# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    street { '140 Market St' }
    city { 'San Francisco' }
    state { 'CA' }
    zipcode { '94105' }
    country { 'United States' }
  end
end
