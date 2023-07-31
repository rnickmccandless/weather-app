# frozen_string_literal: true

FactoryBot.define do
  factory :weather do
    address { FactoryBot.build :address }
  end
end
