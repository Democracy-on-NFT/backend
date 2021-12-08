# frozen_string_literal: true

class BigchaindbCall
  URL = 'http://'.freeze

  def initialize(activity)
    @activity = activity
  end

  def call
    bigchain_post
  end

  private

  attr_reader :activity

  def params
    {
      "title": activity.title,
      "date": activity.date,
      "deputy_legislature_id": activity.deputy_legislature_id
    }
  end

  def bigchain_post
    uri = URI.parse(URL)
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
