# frozen_string_literal: true

FactoryBot.define do
  factory :draft_decision do
    date { Faker::Date.between(from: 1.year.ago, to: 1.day.ago) }
    number { Faker::Number.between(from: 1, to: 300) }
    title { Faker::Lorem.paragraph }
    association :deputy_legislature
  end
end
