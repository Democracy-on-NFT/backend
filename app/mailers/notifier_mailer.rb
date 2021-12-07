# frozen_string_literal: true

class NotifierMailer < ApplicationMailer
  def monthly_notification(electoral_circumscription_id)
    receivers_list = Notification
      .where(electoral_circumscription_id: electoral_circumscription_id)
      .map(&:email)
      .uniq

    ec = ElectoralCircumscription.find(electoral_circumscription_id)
    activity_month = "#{Date.current.month - 1} - #{Date.current.year}"
    subject = "Activitatea parlamentarilor din circumscripția #{ec.number} în luna #{activity_month}"

    # TODO: update the logic on this part
    # https://berislavbabic.com/send-pdf-attachments-from-rails-with-wickedpdf-and-actionmailer/
    # https://mailtrap.io/blog/ruby-send-email/
    attachments['ActivitateParlamentari.pdf'] = WickedPdf.new.pdf_from_string(
      render_to_string(
        pdf: 'monthly_report',
        template: 'monthly_report.html.erb',
        locals: { @ec => ec }
      )
    )
    mail(
      bcc: receivers_list,
      subject: subject
    )
  end
end
