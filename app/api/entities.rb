# frozen_string_literal: true

class Entities
  class ElectoralCircumscription < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :number, documentation: { type: Integer }
    expose :county_name
  end

  class Party < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :abbreviation
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
    expose :name
    expose :offices, using: Office
  end

  class Question < Grape::Entity
    expose :number
    expose :title
    expose :date
  end

  class LegislativeInitiative < Grape::Entity
    expose :number
    expose :title
    expose :date
  end

  class SignedMotion < Grape::Entity
    expose :title
    expose :number
    expose :status
    expose :date
  end

  class Speech < Grape::Entity
    expose :title
    expose :date
  end

  class DraftDecision < Grape::Entity
    expose :number
    expose :title
    expose :date
  end

  class Activity < Grape::Entity
    root :activities, :activity

    expose :questions, using: Question, documentation: { is_array: true }
    expose :legislative_initiatives, using: LegislativeInitiative, documentation: { is_array: true }
    expose :signed_motions, using: SignedMotion, documentation: { is_array: true }
    expose :speeches, using: Speech, documentation: { is_array: true }
    expose :draft_decisions, using: DraftDecision, documentation: { is_array: true }
  end

end
