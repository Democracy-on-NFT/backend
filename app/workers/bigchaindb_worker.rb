# frozen_string_literal: true

class BigchaindbWorker
  include Sidekiq::Worker

  def perform(*_args)
    PushActivitiesToBdb.new.call
  end
end
