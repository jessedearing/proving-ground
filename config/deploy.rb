set :application, "JesseDearing.com"
set :repository,  "ssh://jessed@jessedearing.com/~/code/jessedearing.git"
set :deploy_to, '/var/www/jessedearing-rails'
set :rails_env, 'production'
set :user, 'jessed'
set :use_sudo, false


set :scm, :git
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "69.164.207.237"                          # Your HTTP server, Apache/etc
role :app, "69.164.207.237"                          # This may be the same as your `Web` server
role :db,  "69.164.207.237", :primary => true # This is where Rails migrations will run

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end
