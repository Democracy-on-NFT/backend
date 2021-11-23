# frozen_string_literal: true

class DeputiesApi < Grape::API

  resource :deputies do
    desc 'Deputy list' do
      tags %w[deputies]
      http_codes [
                   { code: 200, model: Entities::Deputy, message: 'Deputy list' }
                 ]
    end

    get do
      deputies = Deputy.all
      present deputies, with: Entities::Deputy
    end

    route_param :id do
      desc 'Get parties' do
        tags %w[legislature]
        http_codes [
                     { code: 200, model: Entities::Party, message: 'Parties list' },
                     { code: 404, message: 'Legislature not found' }
                   ]
      end

      params do
        requires :legislature_id, type: Integer
      end
      get do
        deputy = Deputy.find(params[:id])
        legislature = deputy.legislatures.find(params[:legislature_id])
      end

      params do
        requires :legislature_id, type: Integer
      end
      get 'activity' do
        deputy_activity = DeputyLegislature.where(deputy_id: params[:id], legislature_id: params[:legislature_id]).first
        present deputy_activity, with: Entities::Activity
      end
    end
  end
end
