# frozen_string_literal: true

FactoryBot.define do
  factory :deputy do
    name { Faker::Name.name }
    image_link { Faker::File.file_name(dir: 'cdep', ext: 'jpg') }
    email { Faker::Internet.email }
  end

  trait :with_offices do
    transient do
      offices_count { 1 }
    end

    after(:create) do |deputy, evaluator|
      create_list(:office, evaluator.offices_count, deputy: deputy)
    end
  end

  trait :with_parties do
    transient do
      parties_count { 1 }
    end

    after(:create) do |deputy, evaluator|
      create_list(:party, evaluator.parties_count, deputies: [deputy])
    end
  end
end
