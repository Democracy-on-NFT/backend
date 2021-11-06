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
  end
end
