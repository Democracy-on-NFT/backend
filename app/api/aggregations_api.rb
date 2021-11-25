# frozen_string_literal: true

class AggregationsApi < Grape::API
  resource :parties_percentage do
    desc 'Parties percentage per county' do
      tags %w[aggregation]
      http_codes [
        { code: 200, message: 'Parties percentage per county' }
      ]
    end
    get do
      circumscription_deputy_hash = DeputyLegislature.includes(:electoral_circumscription)
        .each_with_object({}) do |dl, h|
        h[dl.deputy_id] = dl.electoral_circumscription.county_name
      end
      party_deputy_hash = DeputyParty.includes(:party).each_with_object({}) do |dp, h|
        h[dp.deputy_id] = dp.party.abbreviation
      end

      parties_percentage = party_deputy_hash.keys.each_with_object({}) do |key, hash|
        circumscription = circumscription_deputy_hash[key]
        party = party_deputy_hash[key]
        hash[circumscription] = {} unless hash.keys.include? circumscription

        if hash[circumscription][party]
          hash[circumscription][party] += 1
        else
          hash[circumscription].merge!(party => 1)
        end
      end

      parties_percentage.map do |circumscription, party_count_hash|
        total = party_count_hash.values.sum.to_f
        party_count_hash.map { |party, count| parties_percentage[circumscription][party] = count / total }
      end

      present parties_percentage
    end
  end
end
