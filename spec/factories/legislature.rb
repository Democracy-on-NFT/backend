# frozen_string_literal: true

FactoryBot.define do
  factory :legislature do
    start_date { Faker::Date.between(from: 30.years.ago, to: 1.year.ago) }
    end_date { start_date + 4.years }
  end
end
