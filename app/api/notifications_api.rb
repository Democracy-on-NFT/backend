# frozen_string_literal: true

class NotificationsApi < Grape::API
  resource :notifications do
    desc 'Notification creation' do
      tags %w[notification]
      http_codes [
        { code: 201, model: Entities::Notification, message: 'Notification created' },
        { code: 400, message: 'Bad request' }
      ]
    end
    params do
      with(documentation: { in: 'body' }) do
        requires :notification, type: Hash do
          requires :email, type: String, allow_blank: false, regexp: /.+@.+/
          requires :electoral_circumscription_id, type: Integer, allow_blank: false,
                   values: -> { ElectoralCircumscription.all.map(&:id) }
        end
      end
    end
    post do
      notification = Notification.create!(params[:notification])
      present notification, with: Entities::Notification
    end
  end
end
