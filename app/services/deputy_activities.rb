# frozen_string_literal: true

class DeputyActivities
  def initialize(legislature_id:, deputy_id:)
    @legislature_id = legislature_id
    @deputy_id = deputy_id
  end

  def call
    deputy_activities_hash
  end

  private

  attr_reader :legislature_id, :deputy_id

  # rubocop:disable Metrics/AbcSize
  def deputy_activities_hash
    dl = deputy_legislature
    deputy_activities = initial_activity
    return deputy_activities if dl.blank?

    deputy_activities[:legislative_initiatives] = group_by_date(dl.legislative_initiatives)
    deputy_activities[:draft_decisions] = group_by_date(dl.draft_decisions)
    deputy_activities[:signed_motions] = group_by_date(dl.signed_motions)
    deputy_activities[:questions] = group_by_date(dl.questions)
    deputy_activities[:speeches] = group_by_date(dl.speeches)

    deputy_activities
  end
  # rubocop:enable Metrics/AbcSize

  def deputy_legislature
    DeputyLegislature.where(legislature_id: legislature_id, deputy_id: deputy_id).first
  end

  def initial_activity
    {
      legislative_initiatives: {},
      signed_motions: {},
      speeches: {},
      draft_decisions: {},
      questions: {}
    }
  end

  def group_by_date(activities)
    activities.group_by { |activity| activity&.date&.strftime('%m-%Y') }.transform_values(&:length)
  end
end
