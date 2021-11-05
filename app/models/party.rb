# frozen_string_literal: true

class Party < ApplicationRecord
  has_many :party_legislature
  has_many :legislatures, through: :party_legislature
end
