# frozen_string_literal: true

FactoryBot.define do
  factory :party do
    name { Faker::Lorem.words(number: 3).join(' ').titleize }
    link { Faker::File.file_name(dir: 'cdep', ext: 'jpg') }
  end
end
