# frozen_string_literal: true

class Deputy < ApplicationRecord
  has_many :offices

  has_many :deputy_parties
  has_many :parties, through: :deputy_parties
end
