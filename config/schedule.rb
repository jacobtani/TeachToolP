set :output, "log/cron_log.log"

every 14.days do
  runner "AdminMailer.reminder_nullify_rewards.deliver_now"
end