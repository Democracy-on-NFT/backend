# frozen_string_literal: true

class Entities
  class County < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :name
  end

  class ElectoralCircumscription < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :number, documentation: { type: Integer }
    expose :county_name
  end
end
