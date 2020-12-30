class InquiryController < ApplicationController
  def form
    @inquiry = Inquiry.new
    render template: 'inquiry/form'
  end

  def confirm
    @inquiry = Inquiry.new(inquiry_params)
    if @inquiry.valid?
      render action: 'confirm'
    else
      render action: 'form'
    end
  end

  private
  def inquiry_params
    params.require(:inquiry).permit(:sender_name, :sender_name_reading ,:sender_mail_address, :message)
  end
end
