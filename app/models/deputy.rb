# frozen_string_literal: true

class Deputy < ApplicationRecord
  has_many :offices

  has_many :deputy_parties
  has_many :parties, through: :deputy_parties

  has_many :deputy_legislatures
  has_many :legislatures, through: :deputy_legislatures

  enum room: { deputat: 1, senator: 0 }
end
