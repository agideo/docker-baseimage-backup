Model.new(:app_log, 'app_log') do
  archive :app_log do |archive|
    archive.root '/srv/app_log'
    archive.add "./"
  end

  store_with Object.const_get(ENV.fetch('STORE_WITH') { 'SFTP' })

  compress_with Gzip

  if ENV['BACKUP_APP_LOG_NOTIFY_URL'].to_s.length > 0
    notify_by HttpPost do |post|
      post.uri = ENV['BACKUP_APP_LOG_NOTIFY_URL']
    end
  end
end
