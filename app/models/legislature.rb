# frozen_string_literal: true

class Legislature < ApplicationRecord
  has_many :party_legislatures
  has_many :parties, through: :party_legislatures

  has_many :deputy_legislatures
  has_many :deputies, through: :deputy_legislatures

  validates :start_date, presence: true
  validates :end_date, presence: true

  after_save :setup_title

  private

  def setup_title
    return if [start_date, end_date].any?(nil)

    update_column(:title, "#{start_date.year} - #{end_date.year}")
  end
end
