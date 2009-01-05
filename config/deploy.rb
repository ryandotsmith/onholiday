#############################################################
#	Application
#############################################################

set :application, "onholiday"
set :deploy_to, "/var/app/#{application}"

#############################################################
#	Settings
#############################################################

default_run_options[:pty] = true
set :use_sudo, false

#############################################################
#	Servers
#############################################################

set :user, "rsmith"
set :domain, "10.0.1.20"
server domain, :app, :web
role :db, domain, :primary => true

#############################################################
#	Subversion
#############################################################

#set :repository,  "svn://10.0.1.18/var/repository/apply"
#set :svn_username, "rsmith"
#set :svn_password, "rsmith"
#set :checkout, "export"

#############################################################
#	Git
#############################################################
set :scm, :git
set :repository, "git@github.com:ryandotsmith/onholiday.git"
set :branch, "master"
set :deploy_via, :remote_cache


#############################################################
#	Passenger
#############################################################
namespace :deploy do
  
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
    run "mkdir #{current_path}/tmp/sessions"
  end

  desc "Symlink shared configs and folders on each release."
    task :symlink_shared do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    end
      
end
after 'deploy:update_code', 'deploy:symlink_shared'
#############################################################
#	Attachment_FU 
#############################################################
