# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Office, type: :model do
  describe 'associations' do
    it { should belong_to(:deputy) }
  end
end
