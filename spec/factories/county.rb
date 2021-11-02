# frozen_string_literal: true

FactoryBot.define do
  factory :county do
    name { Faker::Address.state }
  end
end
