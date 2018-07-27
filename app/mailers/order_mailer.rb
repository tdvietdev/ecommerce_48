class OrderMailer < ApplicationMailer
  add_template_helper ProductsHelper
  def order_infomation order
    @order = order
    mail to: @order.user_email, subject: t(".subject")
  end

  def statistic_order orders
    @orders = orders
    mail to: User.super_admin.email, subject: t(".subject")
  end
end
