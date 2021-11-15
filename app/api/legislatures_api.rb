# frozen_string_literal: true

class LegislaturesApi < Grape::API
  resource :legislatures do
    desc 'Legislature list' do
      tags %w[legislature]
      http_codes [
        { code: 200, model: Entities::Legislature, message: 'Legislature list' }
      ]
    end
    get do
      legislatures = Legislature.all
      present legislatures, with: Entities::Legislature
    end

    route_param :id do
      desc 'Get parties' do
        tags %w[legislature]
        http_codes [
          { code: 200, model: Entities::Party, message: 'Parties list' },
          { code: 404, message: 'Legislature not found' }
        ]
      end
      get 'parties' do
        legislature = Legislature.find(params[:id])
        present legislature.parties, with: Entities::Party
      end

      desc 'Get deputies' do
        tags %w[legislature]
        http_codes [
          { code: 200, model: Entities::Deputy, message: 'Deputies list' },
          { code: 404, message: 'Legislature not found' }
        ]
      end
      get 'deputies' do
        legislature = Legislature.find(params[:id])
        present legislature.deputies, with: Entities::Deputy
      end
    end
  end
end
