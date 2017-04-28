set :output, "/root/Backup/log/cron.log"

if ENV['CRON_BACKUP_APP_LOG_AT'].to_s.length > 0
  every 1.day, at: ENV.fetch('CRON_LOGROTATE_APP_LOG_AT') { '0:01 am'} do
    command "logrotate -f /etc/logrotate.d/app_log.conf"
  end
end

['app_log', 'mysql', 'redis'].each do |trigger|
  time = ENV["CRON_BACKUP_#{trigger.upcase}_AT"]
  next if time.to_s.length <= 0

  every 1.day, at: time do
    command "backup perform -t #{trigger}"
  end
end
