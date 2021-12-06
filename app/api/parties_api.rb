# frozen_string_literal: true

class PartiesApi < Grape::API
  resource :parties do
    desc 'Party list' do
      tags %w[party]
      http_codes [
        { code: 200, model: Entities::Party, message: 'Party list' }
      ]
    end
    get do
      parties = Party.all
      present parties, with: Entities::Party
    end

    route_param :id do
      desc 'Get Party' do
        tags %w[party]
        http_codes [
          { code: 200, model: Entities::Party, message: 'Party list' },
          { code: 404, message: 'Party not found' }
        ]
      end
      get do
        party = Party.find(params[:id])
        present party, with: Entities::FullParty
      end

      desc 'Get deputies activities' do
        tags %w[party]
        http_codes [
          { code: 200, message: 'Deputies aggregated activities' },
          { code: 404, message: 'Party not found!' }
        ]
      end
      params do
        requires :legislature_id, type: Integer, values: -> { Legislature.all.map(&:id) }
      end
      get 'deputies/activity' do
        deputies_ids = Party.find(params[:id]).deputies.map(&:id)
        deputies_per_legislature = DeputyLegislature
          .where(legislature_id: params[:legislature_id], deputy_id: deputies_ids)
        aggregated_activities = {
          total_deputies: deputies_per_legislature.count,
          total_speeches: deputies_per_legislature.sum(&:speeches_count),
          total_questions: deputies_per_legislature.sum(&:questions_count),
          total_draft_decisions: deputies_per_legislature.sum(&:draft_decisions_count),
          total_legislative_initiatives: deputies_per_legislature.sum(&:legislative_initiatives_count),
          total_signed_motions: deputies_per_legislature.sum(&:signed_motions_count)
        }
        present aggregated_activities
      end
    end
  end
end
