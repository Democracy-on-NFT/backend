# frozen_string_literal: true

FactoryBot.define do
  factory :office do
    address { Faker::Address.full_address }
  end
end
