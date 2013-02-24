require "bundler/capistrano"

load "config/recipes/base"
load "config/recipes/nginx"
load "config/recipes/unicorn"
load "config/recipes/postgresql"
load "config/recipes/nodejs"
load "config/recipes/rbenv"
load "config/recipes/check"

server "198.211.96.39", :web, :app, :db, primary: true

set :user, "deployer"
set :application, "agilechamp"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false
set :host_name, "agilechamp.com"

set :scm, "git"
set :repository, "git@github.com:jimknight/agility.git"
set :branch, "master"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

namespace :deploy do
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
  task :upload_settings do
    top.upload("config/application.yml", "#{release_path}/config/application.yml", :via => :scp)
  end
end

after 'deploy:update_code', 'deploy:symlink_uploads', 'deploy:upload_settings'
after "deploy", "deploy:cleanup" # keep only the last 5 releases