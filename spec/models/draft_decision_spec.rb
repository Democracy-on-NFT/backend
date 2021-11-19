# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DraftDecision, type: :model do
  describe 'associations' do
    it { should belong_to(:deputy_legislature) }
  end
end
