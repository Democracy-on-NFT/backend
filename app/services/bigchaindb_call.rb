# frozen_string_literal: true

class BigchaindbCall
  URL = ENV['BDB_URL']

  def initialize(activity)
    @activity = activity
    @id = activity.deputy_legislature_id
  end

  def call
    bigchain_post
  end

  private

  attr_reader :activity, :id

  def params
    {
      "data":
        {
          "title": activity.title,
          "date": activity.date || '',
          "type": activity_type(activity.class.name)
        }
    }
  end

  def activity_type(class_name)
    case class_name
    when /LegislativeInitiative/
      'legislative_initiatives'
    when /SignedMotion/
      'signed_motions'
    when /Speech/
      'speeches'
    when /DraftDecision/
      'draft_decisions'
    when /Question/
      'questions'
    end
  end

  def bigchain_post
    url = "#{URL}/api/v1/deputies/#{id}/activities/"
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = false
    request = Net::HTTP::Post.new(
      uri.path,
      'Content-Type' => 'application/json;charset=utf-8'
    )
    request.body = params.to_json
    response_body = http.request(request).body
    JSON.parse(response_body)
  end
end
