# frozen_string_literal: true

class AggregationsApi < Grape::API
  resource :deputies_aggregations do
    desc 'Number of deputies by county' do
      tags %w[aggregation]
      http_codes [
        { code: 200, message: 'Number of deputies by county' }
      ]
    end
    params do
      requires :legislature_id, type: Integer
    end
    get do
      deputies_by_county = DeputyLegislature.where(legislature_id: params[:legislature_id])
        .includes(:electoral_circumscription, :deputy)
        .group_by { |dl| dl.electoral_circumscription.county_name }

      deputies_number_by_county = deputies_by_county.each_with_object({}) do |(key, value), hash|
        count_by_room = { deputati: 0, senatori: 0 }
        value.each do |dl|
          if dl.deputy.room == 'deputat'
            count_by_room[:deputati] += 1
          else
            count_by_room[:senatori] += 1
          end
        end
        hash[key] = count_by_room
      end

      present deputies_number_by_county
    end
  end
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
