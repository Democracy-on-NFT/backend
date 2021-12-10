# frozen_string_literal: true

class PushActivitiesToBdb
  # rubocop:disable Metrics/AbcSize
  def call
    month_ago = Date.today - 1.month

    Question.where('date >= :date', date: month_ago).find_each do |q|
      BigchaindbCall.new(q).call
    end

    DraftDecision.where('date >= :date', date: month_ago).find_each do |dd|
      BigchaindbCall.new(dd).call
    end

    Speech.where('date >= :date', date: month_ago).find_each do |s|
      BigchaindbCall.new(s).call
    end

    SignedMotion.where('date >= :date', date: month_ago).find_each do |sm|
      BigchaindbCall.new(sm).call
    end

    LegislativeInitiative.where('date >= :date', date: month_ago).find_each do |li|
      BigchaindbCall.new(li).call
    end
  end
  # rubocop:enable Metrics/AbcSize
end
