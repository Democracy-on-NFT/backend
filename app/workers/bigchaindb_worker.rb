# frozen_string_literal: true

class ScraperWorker
  include Sidekiq::Worker

  def perform(*_args)
    Question.all.find_each do |q|
      BigchaindbCall.new(q).call
    end

    DraftDecision.all.find_each do |dd|
      BigchaindbCall.new(dd).call
    end

    Speech.all.find_each do |s|
      BigchaindbCall.new(s).call
    end

    SignedMotion.all.find_each do |sm|
      BigchaindbCall.new(sm).call
    end

    LegislativeInitiative.all.find_each do |li|
      BigchaindbCall.new(li).call
    end
  end
end
