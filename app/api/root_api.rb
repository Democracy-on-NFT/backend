# frozen_string_literal: true

class RootApi < Grape::API
  format :json

  rescue_from ActiveRecord::RecordNotFound do
    error!('Not Found', 404)
  end

  mount ElectoralCircumscriptionsApi
  mount PartiesApi
  mount LegislaturesApi

  add_swagger_documentation(
    format: :json,
    base_path: '/api/v1',
    mount_path: 'docs',
    info: { title: 'API docs' },
    models: [],
    array_use_braces: true,
    add_root: true
  )
end
