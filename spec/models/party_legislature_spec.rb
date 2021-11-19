# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PartyLegislature, type: :model do
  describe 'associations' do
    it { should belong_to(:party) }
    it { should belong_to(:legislature) }
  end
end
