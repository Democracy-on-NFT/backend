# frozen_string_literal: true

class Deputy < ApplicationRecord
  enum room: { deputat: 1, senator: 0 }

  has_many :offices

  has_many :deputy_parties
  has_many :parties, through: :deputy_parties

  has_many :deputy_legislatures
  has_many :legislatures, through: :deputy_legislatures

  def current_party
    parties.last
  end

  def current_electoral_circumscription
    deputy_legislatures.last.electoral_circumscription
  end
end
