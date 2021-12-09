# frozen_string_literal: true

class DeputiesApi < Grape::API
  resource :deputies do
    desc 'Deputy list' do
      tags %w[deputies]
      http_codes [
        { code: 200, model: Entities::Deputy, message: 'Deputy list' }
      ]
    end
    params do
      optional :page, type: Integer, default: 1
      optional :per_page, type: Integer, default: 20
      optional :room, type: Integer, values: Deputy.rooms.values
    end
    get do
      room = params.key?(:room) ? params[:room] : Deputy.rooms.values
      deputies = Deputy
        .includes(:offices, :parties, deputy_legislatures: :electoral_circumscription)
        .where(room: room)
      # .page(params[:page]).per(params[:per_page])
      present deputies, with: Entities::Deputy
    end

    route_param :id do
      desc 'Get activity' do
        tags %w[deputies]
        http_codes [
          { code: 200, model: Entities::Activity, message: 'Activity list' },
          { code: 404, message: 'Deputy Legislature not found!' }
        ]
      end

      params do
        requires :legislature_id, type: Integer, values: -> { Legislature.all.map(&:id) }
      end
      get 'activity' do
        deputy_activity = DeputyLegislature.where(deputy_id: params[:id], legislature_id: params[:legislature_id]).first
        present deputy_activity, with: Entities::Activity
      end

      desc 'Get deputy' do
        tags %w[deputies]
        http_codes [
          { code: 200, model: Entities::FullDeputy, message: 'Deputy info' },
          { code: 404, message: 'Deputy not found!' }
        ]
      end

      params do
        requires :legislature_id, type: Integer, values: -> { Legislature.all.map(&:id) }
      end
      get do
        deputy_legislature = DeputyLegislature.where(deputy_id: params[:id],
                                                     legislature_id: params[:legislature_id]).first
        error!('Deputy not found!', 404) if deputy_legislature.blank?
        present deputy_legislature.deputy, with: Entities::FullDeputy
      end
    end
  end
end
