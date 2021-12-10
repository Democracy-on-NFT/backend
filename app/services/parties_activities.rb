# frozen_string_literal: true

class PartiesActivities
  def initialize(deputies_ids:, legislature_id:)
    @deputies_ids = deputies_ids
    @legislature_id = legislature_id
  end

  def call
    activity_per_party_hash
  end

  private

  attr_reader :deputies_ids, :legislature_id

  # rubocop:disable Metrics/AbcSize
  def activity_per_party_hash
    deputies_legislatures = deputy_legislatures
    group_by_room = deputies_legislatures.group_by { |dl| dl.deputy.room }

    activity_per_party = deputies_legislatures.each_with_object({}) do |dl, h|
      abbreviation = dl.deputy.parties.last.abbreviation
      if h[abbreviation]
        h[abbreviation][:legislative_initiatives_count] += dl.legislative_initiatives_count
        h[abbreviation][:signed_motions_count] += dl.signed_motions_count
        h[abbreviation][:speeches_count] += dl.speeches_count
        h[abbreviation][:draft_decisions_count] += dl.draft_decisions_count
        h[abbreviation][:questions_count] += dl.questions_count
        h[abbreviation][:senatori] += (dl.deputy.room == 'senator' ? 1 : 0)
        h[abbreviation][:deputati] += (dl.deputy.room == 'deputat' ? 1 : 0)
      else
        h[abbreviation] = aggregated_activity(dl)
      end
    end

    merge_activities(activity_per_party, group_by_room)
  end
  # rubocop:enable Metrics/AbcSize

  def deputy_legislatures
    if deputies_ids.blank?
      DeputyLegislature.where(legislature_id: Legislature.last).includes(deputy: :parties)
    else
      DeputyLegislature.where(legislature_id: Legislature.last, deputy_id: deputies_ids)
        .includes(deputy: :parties)
    end
  end

  def initial_aggregated_activity
    {
      total_legislative_initiatives: 0,
      total_signed_motions: 0,
      total_speeches: 0,
      total_draft_decisions: 0,
      total_questions: 0
    }
  end

  def aggregated_activity(deputy_legislature)
    {
      legislative_initiatives_count: deputy_legislature.legislative_initiatives_count,
      signed_motions_count: deputy_legislature.signed_motions_count,
      speeches_count: deputy_legislature.speeches_count,
      draft_decisions_count: deputy_legislature.draft_decisions_count,
      questions_count: deputy_legislature.questions_count,
      senatori: deputy_legislature.deputy.room == 'senator' ? 1 : 0,
      deputati: deputy_legislature.deputy.room == 'deputat' ? 1 : 0
    }
  end

  # rubocop:disable Metrics/AbcSize
  def count_total_activities(activity_per_party)
    first = true

    activity_per_party.values.map do |ap_value|
      if first
        activity_per_party.merge!(initial_aggregated_activity)
        first = false
      end

      activity_per_party[:total_legislative_initiatives] += ap_value[:legislative_initiatives_count]
      activity_per_party[:total_signed_motions] += ap_value[:signed_motions_count]
      activity_per_party[:total_speeches] += ap_value[:speeches_count]
      activity_per_party[:total_draft_decisions] += ap_value[:draft_decisions_count]
      activity_per_party[:total_questions] += ap_value[:questions_count]
    end

    activity_per_party
  end
  # rubocop:enable Metrics/AbcSize

  def merge_activities(activity_per_party, group_by_room)
    activity_per_party = count_total_activities(activity_per_party)

    activity_per_party[:total_deputati] = group_by_room['deputat']&.count || 0
    activity_per_party[:total_senatori] = group_by_room['senator']&.count || 0

    activity_per_party
  end
end
