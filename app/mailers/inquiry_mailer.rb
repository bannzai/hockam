class InquiryMailer < ApplicationMailer
  def send_mail(inquiry)
    @inquiry = inquiry
    mail(to: ENV["INQUIRY_MAIL_ADDRESS"], subject: @inquiry.message)
  end
end
