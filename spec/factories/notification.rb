# frozen_string_literal: true

FactoryBot.define do
  factory :notification do
    email { Faker::Internet.email }
    electoral_circumscription { FactoryBot.create(:electoral_circumscription) }
  end
end
