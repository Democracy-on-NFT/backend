# frozen_string_literal: true

class ScraperWorker
  include Sidekiq::Worker

  def perform(*_args)
    ParlamentScraper.crawl!
  end
end
