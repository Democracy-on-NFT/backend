# frozen_string_literal: true

FactoryBot.define do
  factory :office do
    association :deputy
    address { Faker::Address.full_address }
  end
end
