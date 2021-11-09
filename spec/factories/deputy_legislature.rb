# frozen_string_literal: true

FactoryBot.define do
  factory :deputy_legislature do
    association :legislature
    association :deputy
    association :electoral_circumscription
  end
end
