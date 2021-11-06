# frozen_string_literal: true

class Entities
  class ElectoralCircumscription < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :number, documentation: { type: Integer }
    expose :county_name
  end

  class Party < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :name
    expose :link
  end

  class Legislature < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :title
    expose :start_date, documentation: { type: Date }
    expose :end_date, documentation: { type: Date }
  end

  class Office < Grape::Entity
    expose :address
  end

  class Deputy < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :image_link
    expose :email
    expose :offices, using: Office
  end
end
