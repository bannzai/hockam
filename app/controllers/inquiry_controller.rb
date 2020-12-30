class InquiryController < ApplicationController
  def form
    @inquiry = Inquiry.new
    render template: 'inquiry/form'
  end
  def confirm
    render template: 'inquiry/confim'
  end
end
