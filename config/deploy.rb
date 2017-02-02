set :application, 'kindred-britain-edit'
set :repo_url, 'https://github.com/sul-cidr/kb-edit.git'
set :user, 'cidr'

# Default branch is :master
ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call

set :home_directory, "/opt/app/#{fetch(:user)}"
set :deploy_to, "#{fetch(:home_directory)}/#{fetch(:application)}"

# Default value for :linked_files is []
set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w{log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system} # data?

# Default value for keep_releases is 5
set :keep_releases, 5

set :bundle_without, %w(test deployment development).join(' ')

set :rails_env, 'production'
