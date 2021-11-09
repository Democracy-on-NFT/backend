# frozen_string_literal: true

class DeputyLegislature < ApplicationRecord
  belongs_to :deputy
  belongs_to :legislature
  belongs_to :electoral_circumscription

  has_many :legislative_initiatives
end
