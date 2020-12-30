class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    begin
      @inquiry = inquiry
      mail(to: ENV['INQUIRY_TO_MAIL_ADDRESS'], subject: 'hockam.comからお問い合わせがありました')
    rescue StandardError => e
      Rails.logger.error("failed send mail. #{e.message}")
    end
  end
end
