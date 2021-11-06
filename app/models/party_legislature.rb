# frozen_string_literal: true

class PartyLegislature < ApplicationRecord
  belongs_to :party
  belongs_to :legislature
end
