# frozen_string_literal: true

class DeputyParty < ApplicationRecord
  belongs_to :deputy
  belongs_to :party
end
