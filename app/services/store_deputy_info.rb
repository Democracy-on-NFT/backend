# frozen_string_literal: true

class StoreDeputyInfo
  def initialize(data)
    @data = data
  end

  def call
    deputy_legislature
  end

  private

  attr_reader :data

  # rubocop:disable Metrics/AbcSize
  def find_or_create_deputy
    Deputy.find_or_create_by(name: data[:name]) do |deputy|
      deputy.image_link = data[:picture_url]
      deputy.email = data[:email]
      deputy.date_of_birth = parse_date(data[:date_of_birth].to_s)
      deputy.room = deputy_type(data[:room])
    end
  end
  # rubocop:enable Metrics/AbcSize

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

  def offices_mapping(deputy_id)
    data[:addresses].each do |address|
      find_or_create_office(deputy_id, address)
    end
  end

  def parties_mapping(deputy_id)
    data[:parties].each do |deputy_party|
      party = party_by(deputy_party[:party])
      next if party.blank?

      find_or_create_deputy_party(deputy_id, party.id, deputy_party)
    end
  end

  def deputy_legislature
    deputy = find_or_create_deputy

    offices_mapping(deputy.id)
    parties_mapping(deputy.id)

    find_or_create_deputy_legislature(
      deputy.id,
      legislature_by.id,
      electoral_circumscription_by(data[:electoral_circumscription].to_i).id
    )
  end

  def deputy_type(room)
    room == 'DEPUTAT' ? 1 : 0
  end

  def parse_date(string_date)
    Date.parse(string_date)
  rescue Date::Error
    nil
  end
end
