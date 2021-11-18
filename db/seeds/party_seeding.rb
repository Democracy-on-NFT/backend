# frozen_string_literal: true

require 'csv'

def seed_parties
  filename = File.join(Rails.root, '/db/data', 'parties.csv')

  pp "Seeding Parties from #{filename}..."

  CSV.foreach(filename, headers: true) do |row|
    party_information = {
      abbreviation: row[0],
      name: row[1],
      link: row[2]
    }
    Party
      .where(party_information)
      .first_or_create!(party_information)
  end

  pp "Seeding Parties from #{filename} done."
end
