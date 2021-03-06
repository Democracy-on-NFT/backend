# frozen_string_literal: true

require_relative './seeds/electoral_circumscription_seeding'
require_relative './seeds/legislature_seeding'
require_relative './seeds/party_seeding'
require_relative './seeds/party_legislature_seeding'

pp 'Seeding ...'

seed_electoral_circumscriptions
seed_legislatures
seed_parties
seed_parties_legislatures

pp 'Seeding done!'
