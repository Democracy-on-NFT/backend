# frozen_string_literal: true

class ElectoralCircumscription < ApplicationRecord
  has_many :deputy_legislatures
  has_many :notifications
end
