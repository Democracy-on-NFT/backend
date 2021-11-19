# frozen_string_literal: true

require 'csv'

def seed_parties_legislatures
  filename = File.join(Rails.root, '/db/data', 'parties_legislatures.csv')

  pp "Seeding PartiesLegislatures from #{filename}..."

  CSV.foreach(filename, headers: true) do |row|
    party = Party.find_by_abbreviation(row[0])
    legislature = Legislature.find_by_title(row[1])
    party_legislature_information = {
      party_id: party&.id,
      legislature_id: legislature&.id
    }
    PartyLegislature
      .where(party_legislature_information)
      .first_or_create!(party_legislature_information)
  end

  pp "Seeding PartiesLegislatures from #{filename} done."
end
