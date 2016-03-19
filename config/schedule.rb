set :output, "log/cron_log.log"

every 168.hours do
  runner "AdminMailer.reminder_nullify_rewards.deliver_now"
end