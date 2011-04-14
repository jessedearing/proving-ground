namespace :unicorn do
  task :start do
    Dir.chdir(Rails.root)
    `unicorn_rails -c config/unicorn.rb -D`
  end

  task :stop do
    pid = File.read("#{Rails.root}/tmp/pids/unicorn.pid").to_i
    Process.kill("QUIT", pid)
  end

  task :restart do
    pid = File.read("#{Rails.root}/tmp/pids/unicorn.pid").to_i
    Process.kill("USR2", pid)
  end
end
