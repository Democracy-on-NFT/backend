# frozen_string_literal: true

require 'csv'

def seed_electoral_circumscriptions
  filename = File.join(Rails.root, '/db/data', 'electoral_circumscriptions.csv')

  pp "Seeding ECs from #{filename}..."

  CSV.foreach(filename, :headers => true) do |row|
    ec_information = {
      number: row[0],
      county_name: row[1]
    }
    ElectoralCircumscription.where(ec_information).first_or_create!(ec_information)
  end

  pp "Seeding ECs from #{filename} done."
end
