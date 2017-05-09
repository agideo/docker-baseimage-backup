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

Notifier::HttpPost.defaults do |post|
  post.on_success = true
  post.on_warning = false
  post.on_failure = false
end
