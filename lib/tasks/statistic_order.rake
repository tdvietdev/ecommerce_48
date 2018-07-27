namespace :cron_job do
  task statistic_order: :environment do
    if (Time.now + 1.hour).day == 1
      @orders = Order.success
                     .from_this_month
                     .includes :user, order_details: [:product]
      OrderMailer.statistic_order(@orders).deliver_now
    end
  end
end
