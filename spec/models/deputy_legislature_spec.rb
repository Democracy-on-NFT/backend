# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DeputyLegislature, type: :model do
  describe 'associations' do
    it { should belong_to(:deputy) }
    it { should belong_to(:legislature) }
    it { should belong_to(:electoral_circumscription) }

    it { should have_many(:legislative_initiatives) }
    it { should have_many(:signed_motions) }
    it { should have_many(:speeches) }
    it { should have_many(:draft_decisions) }
    it { should have_many(:questions) }
  end
end
