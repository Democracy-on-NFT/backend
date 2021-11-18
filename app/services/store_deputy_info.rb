# frozen_string_literal: true

class StoreDeputyInfo
  def initialize(data)
    @data = data
  end

  def call
    deputy = find_or_create_deputy(data)
    ec_number = data[:electoral_circumscription].to_i
    electoral_circumscription = electoral_circumscription_by(ec_number)
    legislature = legislature_by

    find_or_create_deputy_legislature(deputy.id, legislature.id, electoral_circumscription.id)

    data[:addresses].each do |address|
      find_or_create_office(deputy.id, address)
    end

    data[:parties].each do |deputy_party|
      party = party_by(deputy_party[:party])
      # there may be some issues with encoding, eg. Neafiliați
      next if party.blank?

      find_or_create_deputy_party(deputy.id, party.id, deputy_party)
    end

  end

  private

  attr_reader :data

  def find_or_create_deputy(data)
    Deputy.find_or_create_by(name: data[:name]) do |deputy|
      deputy.image_link = data[:picture_url]
      deputy.email = data[:email]
    end
  end

  def find_or_create_deputy_legislature(deputy_id, legislature_id, ec_id)
    DeputyLegislature.find_or_create_by(
      deputy_id: deputy_id,
      legislature_id: legislature_id,
      electoral_circumscription_id: ec_id
    )
  end

  def find_or_create_deputy_party(deputy_id, party_id, party_info)
    DeputyParty.find_or_create_by(deputy_id: deputy_id, party_id: party_id) do |dp|
      dp.start_date = party_info[:start_date]
      dp.end_date = party_info[:end_date]
    end
  end

  def electoral_circumscription_by(number)
    ElectoralCircumscription.find_by(number: number || 0)
  end

  def legislature_by(title = '2020 - 2024')
    Legislature.find_by_title(title)
  end

  def party_by(abbreviation)
    Party.find_by(abbreviation: abbreviation)
  end

  def find_or_create_office(deputy_id, address)
    Office.find_or_create_by(deputy_id: deputy_id, address: address)
  end
end
