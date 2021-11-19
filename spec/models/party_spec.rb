# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Party, type: :model do
  describe 'associations' do
    it { should have_many(:party_legislatures) }
    it { should have_many(:legislatures) }
    it { should have_many(:deputy_parties) }
    it { should have_many(:deputies) }
  end
end
