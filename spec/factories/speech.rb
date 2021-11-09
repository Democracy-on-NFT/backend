# frozen_string_literal: true

FactoryBot.define do
  factory :speeches do
    title { Faker::Lorem.paragraph }
    date { Faker::Date.between(from: 1.year.ago, to: 1.day.ago) }
    association :deputy_legislature
  end
end
