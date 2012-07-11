require 'bundler/capistrano'

set :application, "JesseDearing.com"
set :repository,  "git@github.com:jessedearing/proving-ground.git"
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
  task :create_cache_dirs do
    # run "cd #{current_path} && #{sudo} mkdir tmp/cache"
    # run "cd #{current_path} && #{sudo} mkdir tmp/sessions"
    run "cd #{current_path} && #{sudo} chown -R www-data:www-data tmp"
  end
  task :chown_public_dir do
    run "cd #{current_path} && #{sudo} chown -R www-data:www-data public"
  end
  task :copy_db_config do
    run "cp -f /etc/jessedearing/database.yml #{current_path}/config/"
  end
  task :precompile_assets do
    run "cd #{release_path} && #{sudo} chown -R jessed:www-data public"
    run "cd #{release_path} && bundle exec rake assets:precompile"
  end
end

before("deploy:symlink", "deploy:precompile_assets")

after("deploy:symlink", "deploy:create_cache_dirs")
after("deploy:symlink", "deploy:chown_public_dir")
after("deploy:symlink", "deploy:copy_db_config")
