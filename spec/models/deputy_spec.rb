# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Deputy, type: :model do
  describe 'associations' do
    it { should have_many(:offices) }
    it { should have_many(:deputy_parties) }
    it { should have_many(:parties) }
    it { should have_many(:deputy_legislatures) }
    it { should have_many(:legislatures) }
  end
end
