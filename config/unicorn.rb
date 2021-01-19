def rails_root
  require "pathname"
  path = Pathname.new(__FILE__) + "../../"
  return path.to_s
end

worker_processes Integer(ENV["WEB_CONCURRENCY"] || 8) # 子プロセスいくつ立ち上げるか
timeout 15000 #30秒Railsが反応しなければWorkerをkillしてタイムアウト
preload_app true #後述

# 同一マシンでNginxとプロキシ組むならsocketのが高速ぽい(後述ベンチ)
listen File.expand_path(rails_root + '/tmp/sockets/unicorn.sock', __FILE__)

puts "-----------------"
puts rails_root
puts ENV['RAILS_ENV']
puts rails_root + '/tmp/pids/unicorn.pid'
puts "-----------------"
# pid file path Capistranoとか使う時は要設定か
pid rails_root + '/tmp/pids/unicorn.pid'

# ログ
stderr_path rails_root + '/log/unicorn.log'
stdout_path rails_root + '/log/unicorn.log'

before_fork do |server, worker|
  old_pid = "#{ server.config[:pid] }.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      # 古いマスターがいたら死んでもらう
      Process.kill("QUIT", File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
  Signal.trap 'TERM' do
    puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
  end

  defined?(ActiveRecord::Base) and
    ActiveRecord::Base.establish_connection
end