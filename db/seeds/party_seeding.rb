# frozen_string_literal: true

require 'csv'

def seed_parties
  filename = File.join(Rails.root, '/db/data', 'parties.csv')

  pp "Seeding Parties from #{filename}..."

  CSV.foreach(filename, headers: true) do |row|
    party_information = {
      abbreviation: row[0],
      name: row[1]
    }
    # https://newbedev.com/rails-create-or-update-magic
    Party.where(party_information).first_or_initialize(party_information).tap do |party|
      party.link = row[2]
      party.logo = row[3]
      party.save
    end
  end

  pp "Seeding Parties from #{filename} done."
end
