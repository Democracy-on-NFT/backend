# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Deputy, type: :model do
  describe 'associations' do
    it { should have_many(:offices) }
  end
end
