class NotifierMailer < ApplicationMailer
  def receipt_email(order, line_item)
    @order = order
    @line_item = line_item
    mail(to: @order.email, from: 'no-reply@jungle.com', subject: "Your Jungle order #{order.id}") do |format|
      format.html
    end
  end
end
