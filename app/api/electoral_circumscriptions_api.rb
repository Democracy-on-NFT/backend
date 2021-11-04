# frozen_string_literal: true

class ElectoralCircumscriptionsApi < Grape::API
  resource :electoral_circumscriptions do
    desc 'ElectoralCircumscription list' do
      tags %w[electoral_circumscription]
      http_codes [
        { code: 200, model: Entities::ElectoralCircumscription, message: 'Electoral Circumscription list' }
      ]
    end
    get do
      electoral_circumscriptions = ElectoralCircumscription.all
      present electoral_circumscriptions, with: Entities::ElectoralCircumscription
    end
  end
end
