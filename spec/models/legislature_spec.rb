# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Legislature, type: :model do
  describe 'associations' do
    it { should have_many(:party_legislatures) }
    it { should have_many(:parties) }
    it { should have_many(:deputy_legislatures) }
    it { should have_many(:deputies) }
  end

  describe 'validations' do
    it { should validate_presence_of(:start_date) }
    it { should validate_presence_of(:end_date) }
  end

  describe '#save' do
    let(:start_date) { Date.today }
    let(:end_date) { start_date + 4.years }
    let(:legislature) { FactoryBot.create(:legislature, start_date: start_date, end_date: end_date) }

    it 'sets the title correctly' do
      expect(legislature.title).to eq("#{start_date.year} - #{end_date.year}")
    end
  end
end
