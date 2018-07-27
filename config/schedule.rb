job_type :only_last_day, "[ \"$(/bin/date +%d -d tomorrow)\" = \"01\" ] && cd :path && :environment_variable=:environment bundle exec rake :custom_rake_task"

every "30 10 28-31 * *" do
  only_last_day "custom_task", :custom_rake_task => "cron_job:statistic_order"
end

