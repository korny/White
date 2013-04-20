require 'bundler/capistrano'
require './lib/capistrano_database'

set :application, "White"

set :scm, :git
set :repository, "git@github.com:korny/White.git"
set :branch, "master"
set :deploy_via, :remote_cache
set :use_sudo, false

server "rubychan.de", :app, :web, :db, :primary => true

set :ssh_options, { :forward_agent => true }

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# If you aren't deploying to /u/apps/#{application} on the target
# servers (which is the default), you can specify the actual location
# via the :deploy_to variable:
set :deploy_to, "/var/apps/#{application}"

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end

default_run_options[:pty] = true
