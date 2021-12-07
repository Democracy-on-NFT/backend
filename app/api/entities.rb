# frozen_string_literal: true

class Entities
  class ElectoralCircumscription < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :number, documentation: { type: Integer }
    expose :county_name
  end

  class Notification < Grape::Entity
    expose :email
    expose :electoral_circumscription, using: ElectoralCircumscription
  end

  class Party < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :abbreviation
    expose :name
    expose :link
    expose :logo
  end

  class Legislature < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :title
    expose :start_date, documentation: { type: Date }
    expose :end_date, documentation: { type: Date }
  end

  class FullParty < Party
    expose :legislatures, using: Legislature, documentation: { is_array: true }
  end

  class Office < Grape::Entity
    expose :address
  end

  class DeputyLegislature < Grape::Entity
    expose :legislative_initiatives_count, as: :legislative_initiatives
    expose :signed_motions_count, as: :signed_motions
    expose :speeches_count, as: :speeches
    expose :draft_decisions_count, as: :draft_decisions
    expose :questions_count, as: :questions
    expose :legislature, using: Legislature
    expose :electoral_circumscription, using: ElectoralCircumscription
  end

  class Deputy < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :image_link
    expose :email
    expose :name
    expose :date_of_birth
    expose :room
    expose :current_party, as: :party, using: Party
    expose :current_electoral_circumscription, as: :circumscription, using: ElectoralCircumscription
  end

  class DeputyParty < Grape::Entity
    expose :start_date
    expose :end_date
    expose :party, using: Party
  end

  class FullDeputy < Deputy
    expose :offices, using: Office, documentation: { is_array: true }
    expose :deputy_parties, using: DeputyParty, as: :parties, documentation: { is_array: true }
    expose :deputy_legislatures, using: DeputyLegislature, as: :activities, documentation: { is_array: true }
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
