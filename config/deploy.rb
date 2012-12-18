# RVM bootstrap
$:.unshift(File.expand_path("./lib", ENV['rvm_path']))
require 'rvm/capistrano'
require "bundler/capistrano"
require "whenever/capistrano"
load 'deploy/assets'
require './config/initializers/constant'

set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user
set :whenever_command, "bundle exec whenever"

# main details
set :application, "oflunch"
remote_ip = OFLUNCH_SERVER_IP
role :web, remote_ip
role :app, remote_ip
role :db,  remote_ip, :primary => true

# server details
default_run_options[:pty] = true
ssh_options[:forward_agent] = true
set :deploy_to, "/opt/www/oflunch"
set :deploy_via, :remote_cache
set :user, "luke"
set :use_sudo, false

# repo details
set :scm, :git
set :repository, "git://github.com/ilstar/OFLunch.git"
set :branch, "master"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  def cmd_application_server(sign)
    run "cd #{release_path} && bundle exec thin -C config/thin.yml #{sign}"
  end

  task :start, :roles => :app do
    cmd_application_server('start')
  end

  task :stop, :roles => :app do
    cmd_application_server('stop')
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    cmd_application_server('restart')
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/config.yml #{release_path}/config/config.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'
