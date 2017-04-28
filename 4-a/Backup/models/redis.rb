Model.new(:redis, 'redis') do
  database Redis do |db|
    db.mode               = :sync
    db.host               = ENV.fetch('REDIS_SERVER_HOST') { 'redis' }
    db.port               = ENV.fetch('REDIS_SERVER_PORT') { 6379 }
    db.password           = ENV.fetch('REDIS_SERVER_PASSWORD') { '' }
    db.additional_options = []
  end

  store_with SFTP

  compress_with Gzip

  if ENV['BACKUP_REDIS_NOTIFY_URL'].to_s.length > 0
    notify_by HttpPost do |post|
      post.uri = ENV['BACKUP_REDIS_NOTIFY_URL']
    end
  end
end
