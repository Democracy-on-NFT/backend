# frozen_string_literal: true

class CountiesApi < Grape::API
  resource :counties do
    desc 'Counties list' do
      tags %w[counties]
      http_codes [
        { code: 200, model: Entities::County, message: 'Counties list' }
      ]
    end
    get do
      counties = County.all
      present counties, with: Entities::County
    end
  end
end
