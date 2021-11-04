# frozen_string_literal: true

class Entities
  class ElectoralCircumscription < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :number, documentation: { type: Integer }
    expose :county_name
  end
end
