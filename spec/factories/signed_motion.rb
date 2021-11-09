# frozen_string_literal: true

FactoryBot.define do
  factory :signed_motion do
    title { Faker::Lorem.paragraph }
    number { Faker::Number.between(from: 1, to: 300) }
    date { Faker::Date.between(from: 1.year.ago, to: 1.day.ago) }
    status { Faker::Number.between(from: 0, to: 10) }
    association :deputy_legislature
  end
end
