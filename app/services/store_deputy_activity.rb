# frozen_string_literal: true

class StoreDeputyActivity
  def initialize(data:, deputy_legislature:)
    @data = data
    @deputy_legislature = deputy_legislature
    @deputy_legislature_id = deputy_legislature.id
  end

  def call
    deputy_activity
  end

  private

  attr_reader :data, :deputy_legislature, :deputy_legislature_id

  def find_or_create_legislative_initiative(li_info)
    LegislativeInitiative.find_or_create_by(
      number: li_info[:number],
      title: li_info[:title],
      date: parse_date(li_info[:date].to_s),
      deputy_legislature_id: deputy_legislature_id
    )
  end

  def find_or_create_signed_motion(motion_info)
    SignedMotion.find_or_create_by(
      title: motion_info[:title],
      number: motion_info[:number],
      date: parse_date(motion_info[:date].to_s),
      status: motion_info[:status],
      deputy_legislature_id: deputy_legislature_id
    )
  end

  def find_or_create_speech(speech_info)
    speech_title = speech_info[:title]
    title = [speech_title.fetch(:first, ''), speech_title.fetch(:second, '')].join(' ')

    Speech.find_or_create_by(
      title: title,
      date: parse_date(speech_info[:date].to_s),
      deputy_legislature_id: deputy_legislature_id
    )
  end

  def find_or_create_draft_decision(decision_info)
    DraftDecision.find_or_create_by(
      title: decision_info[:title],
      number: decision_info[:number],
      date: parse_date(decision_info[:date].to_s),
      deputy_legislature_id: deputy_legislature_id
    )
  end

  def find_or_create_question(question_info)
    Question.find_or_create_by(
      title: question_info[:title],
      kind: question_type(question_info[:kind]),
      number: question_info[:number],
      date: parse_date(question_info[:date].to_s),
      deputy_legislature_id: deputy_legislature_id
    )
  end

  def legislative_initiatives_mapping
    return unless data.key?(:legislative_initiatives)

    data[:legislative_initiatives].each do |li|
      find_or_create_legislative_initiative(li)
    end
  end

  def motions_signed_mapping
    return unless data.key?(:motions_signed)

    data[:motions_signed].each do |motion|
      find_or_create_signed_motion(motion)
    end
  end

  def speeches_mapping
    return unless data.key?(:speakings)

    data[:speakings].each do |speech|
      find_or_create_speech(speech)
    end
  end

  def draft_decisions_mapping
    return unless data.key?(:draft_decisions)

    data[:draft_decisions].each do |decision|
      find_or_create_draft_decision(decision)
    end
  end

  def questions_mapping
    return unless data.key?(:questions)

    data[:questions].each do |question|
      find_or_create_question(question)
    end
  end

  def deputy_legislature_activity_counts
    deputy_legislature.update(
      legislative_initiatives_count: count_or_zero(:legislative_initiatives),
      signed_motions_count: count_or_zero(:motions_signed),
      speeches_count: count_or_zero(:speakings),
      draft_decisions_count: count_or_zero(:draft_decisions),
      questions_count: count_or_zero(:questions)
    )
  end

  def parse_date(string_date)
    Date.parse(string_date)
  rescue Date::Error
    nil
  end

  def question_type(kind)
    kind == 'Interpelarea' ? 1 : 0
  end

  def count_or_zero(key)
    data.key?(key) ? data[key].count : 0
  end

  def deputy_activity
    deputy_legislature_activity_counts
    legislative_initiatives_mapping
    motions_signed_mapping
    speeches_mapping
    draft_decisions_mapping
    questions_mapping
  end
end
