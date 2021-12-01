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
    end
  end
end
