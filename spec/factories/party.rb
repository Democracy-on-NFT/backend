# frozen_string_literal: true

FactoryBot.define do
  factory :party do
    name { Faker::Lorem.words(number: 3).join(' ').titleize }
    abbreviation { Faker::Hacker.abbreviation }
    link { Faker::File.file_name(dir: 'cdep', ext: 'jpg') }
    logo { Faker::File.file_name(dir: 'logo', ext: 'jpg') }

    trait :with_deputies do
      transient do
        deputies_count { 1 }
      end

      after(:create) do |party, evaluator|
        create_list(:deputy, evaluator.deputies_count, parties: [party])
      end
    end
  end
end
