# frozen_string_literal: true

class Legislature < ApplicationRecord
  has_many :party_legislature
  has_many :parties, through: :party_legislature

  validates :start_date, presence: true
  validates :end_date, presence: true

  after_save :setup_title

  private

  def setup_title
    return if [start_date, end_date].any?(nil)

    update_column(:title, "#{start_date.year} - #{end_date.year}")
  end
end
