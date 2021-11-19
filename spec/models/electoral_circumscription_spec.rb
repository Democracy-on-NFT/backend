# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ElectoralCircumscription, type: :model do
  describe 'associations' do
    it { should have_many(:deputy_legislatures) }
  end
end
