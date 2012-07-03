require "bundler/capistrano"
load 'deploy/assets' # this is a rails 3.0 app

set   :domain,        "69.172.229.224"
role  :web,           domain
role  :app,           domain
role  :db,            domain, :primary => true

# Fill user in - if remote user is different to your local user
set :user, "rails"

default_run_options[:pty] = true

set :application, "agilechamp"
set :scm, :git
set :repository,  "."
set :deploy_via, :copy
set :deploy_to, "/home/#{user}/#{application}"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
  task :symlink_uploads do
    run "ln -nfs #{shared_path}/uploads  #{release_path}/public/uploads"
  end
  task :upload_settings do
  	top.upload("config/application.yml", "#{release_path}/config/application.yml", :via => :scp)
  end
end

after 'deploy:update_code', 'deploy:symlink_uploads', 'deploy:upload_settings'