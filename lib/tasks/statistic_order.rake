namespace :cron_job do
  task statistic_order: :environment do
    if (Time.now + 1.hour).day == 1
      @orders = Order.success
                     .from_this_month
                     .includes :user, order_details: [:product]
      OrderMailer.statistic_order(@orders).deliver_now
      ChatWork::Message.create room_id: Settings.chatwork.chatroom_id,
        body: message_chatwork(@orders)
    end
  end
end

def message_chatwork orders
  message = "[To:#{Settings.chatwork.admin_id}]"
  orders.each do |order|
    list_product = ""
    order.order_details.each do |product|
      list_product << product.product_name + "X" + product.quantity.to_s + "\n"
    end
    list_product << order.grand_total.to_s
    message << tag(:info,
      tag(:title, order.user_name + " : " + order.created_at.to_s(:db)) +
      tag(:info, list_product))
  end
  tag :info, I18n.t("chatwork.title") + message
end

def tag name, content
  "[#{name}]" + content + "[/#{name}]"
end
