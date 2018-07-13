class OrderMailer < ApplicationMailer
  def order_infomation order
    @order = order
    mail to: @order.user_email, subject: "Account activation"
  end
end
