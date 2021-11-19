# frozen_string_literal: true

require 'csv'

def seed_legislatures
  filename = File.join(Rails.root, '/db/data', 'legislatures.csv')

  pp "Seeding Legislatures from #{filename}..."

  CSV.foreach(filename, headers: true) do |row|
    legislature_information = {
      start_date: row[0]&.to_date,
      end_date: row[1]&.to_date
    }
    Legislature
      .where(legislature_information)
      .first_or_create!(legislature_information)
  end

  pp "Seeding Legislatures from #{filename} done."
end
