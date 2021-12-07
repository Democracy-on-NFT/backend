# frozen_string_literal: true

class NotifierWorker
  include Sidekiq::Worker

  def perform(*_args)
    ec_ids = ElectoralCircumscription.pluck(:id)
    ec_ids.each do |ec_id|
      NotifierMailer.monthly_notification(ec_id).deliver
    end
  end
end
