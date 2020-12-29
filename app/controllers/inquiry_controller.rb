class InquiryController < ApplicationController
  def form
    render template: 'inquiry/form'
  end
end
