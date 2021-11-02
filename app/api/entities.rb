# frozen_string_literal: true

class Entities
  class County < Grape::Entity
    expose :id, documentation: { type: Integer }
    expose :name
  end
end
