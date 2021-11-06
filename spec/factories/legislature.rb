# frozen_string_literal: true

FactoryBot.define do
  factory :legislature do
    start_date { Faker::Date.between(from: 30.years.ago, to: 1.year.ago) }
    end_date { start_date + 4.years }

    trait :with_parties do
      transient do
        parties_count { 1 }
      end

      after(:create) do |legislature, evaluator|
        create_list(:party, evaluator.parties_count, legislatures: [legislature])
      end
    end

    trait :with_deputies do
      transient do
        deputies_count { 1 }
      end

      after(:create) do |legislature, evaluator|
        create_list(:deputy, evaluator.deputies_count, legislatures: [legislature])
      end
    end
  end
end
