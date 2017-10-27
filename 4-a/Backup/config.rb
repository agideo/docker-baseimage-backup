# encoding: utf-8

# Backup v4.x Configuration

Storage::SFTP.defaults do |server|
  server.username   = ENV['SFTP_USERNAME']
  server.password   = ENV['SFTP_PASSWORD']
  server.ip         = ENV['SFTP_IP']
  server.port       = ENV['SFTP_PORT']
  server.path       = ENV['SFTP_UPLOAD_PATH']
  server.keep       = 1024
end

Storage::Local.defaults do |local|
  local.path = '/backup-data/'
  # Use a number or a Time object to specify how many backups to keep.
  local.keep = ENV.fetch('LOCAL_KEEP') { 5 }.to_i
end

Notifier::HttpPost.defaults do |post|
  post.on_success = true
  post.on_warning = false
  post.on_failure = false
end
