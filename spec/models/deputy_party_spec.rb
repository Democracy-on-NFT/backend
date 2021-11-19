# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeputyParty, type: :model do
  describe 'associations' do
    it { should belong_to(:deputy) }
    it { should belong_to(:party) }
  end
end
