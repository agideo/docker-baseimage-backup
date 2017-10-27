Model.new(:mysql, 'mysql') do
  database MySQL do |db|
    db.name               = ENV['MYSQL_SERVER_DATABASE']
    db.username           = ENV.fetch('MYSQL_SERVER_USERNAME') { 'root' }
    db.password           = ENV.fetch('MYSQL_SERVER_PASSWORD') { 'root' }
    db.host               = ENV.fetch('MYSQL_SERVER_HOST') { 'mysql' }
    db.port               = ENV.fetch('MYSQL_SERVER_PORT') { 3306 }
    db.additional_options = ["--quick", "--single-transaction"]
    db.prepare_backup = true # see https://github.com/meskyanichi/backup/pull/606 for more information
  end

  store_with Object.const_get(ENV.fetch('STORE_WITH') { 'SFTP' })

  compress_with Gzip

  if ENV['BACKUP_MYSQL_NOTIFY_URL'].to_s.length > 0
    notify_by HttpPost do |post|
      post.uri = ENV['BACKUP_MYSQL_NOTIFY_URL']
    end
  end
end
