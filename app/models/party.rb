# frozen_string_literal: true

class Party < ApplicationRecord
  has_many :party_legislatures
  has_many :legislatures, through: :party_legislatures

  has_many :deputy_parties
  has_many :deputies, through: :deputy_parties
end
