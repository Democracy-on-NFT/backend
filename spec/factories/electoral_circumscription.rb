# frozen_string_literal: true

FactoryBot.define do
  factory :electoral_circumscription do
    county_name { Faker::Address.state }
    number { Faker::Number.between(from: 1, to: 42) }
  end
end
