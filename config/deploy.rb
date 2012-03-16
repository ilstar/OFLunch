# RVM bootstrap
$:.unshift(File.expand_path("./lib", ENV['rvm_path']))
require 'rvm/capistrano'
require "bundler/capistrano"
load 'deploy/assets'
set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user

# main details
set :application, "oflunch"
role :web, "10.64.17.47"
role :app, "10.64.17.47"
role :db,  "10.64.17.47", :primary => true

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
set :branch, "release"
set :git_enable_submodules, 1

# tasks
namespace :deploy do
  task :start, :roles => :app do
    run "thin start -C #{release_path}/config/thin.yml"
  end

  task :stop, :roles => :app do
    run "thin stop -C #{release_path}/config/thin.yml"
  end

  desc "Restart Application"
  task :restart, :roles => :app do
    stop
    start
  end

  desc "Symlink shared resources on each release"
  task :symlink_shared, :roles => :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:symlink_shared'

namespace :bundler do
  desc "Symlink bundled gems on each release"
  task :symlink_bundled_gems, :roles => :app do
    run "mkdir -p #{shared_path}/bundled_gems"
    run "ln -nfs #{shared_path}/bundled_gems #{release_path}/vendor/bundle"
  end

  desc "Install for production"
  task :install, :roles => :app do
    run "cd #{release_path} && bundle install"
  end

end

after 'deploy:update_code', 'bundler:symlink_bundled_gems'
after 'deploy:update_code', 'bundler:install'
