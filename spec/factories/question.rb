# frozen_string_literal: true

FactoryBot.define do
  factory :question do
    title { Faker::Lorem.paragraph }
    number { Faker::Number.between(from: 0, to: 300) }
    date { Faker::Date.between(from: 1.year.ago, to: 1.day.ago) }
    kind { Question.kinds.values.sample }
    association :deputy_legislature
  end
end
