set :repo_url,        'https://gitlab.com/flosscoach/flosscoach'
set :application,     'flosscoach'
set :user,            'flosscoach'

# Don't change these unless you know what you're doing
#set :pty,             true
#set :use_sudo,        false
#set :stage,           :production
#set :deploy_via,      :remote_cache
#set :deploy_to,       "/home/#{fetch(:user)}/apps/#{fetch(:application)}"
set :ssh_options,     { forward_agent: true, user: fetch(:user), keys: %w(~/.ssh/id_rsa.pub) }
#
#set :migration_role, :app

## Defaults:
# set :branch,        :master
# set :format,        :pretty
# set :log_level,     :debug
#set :keep_releases, 1

## Linked Files & Directories (Default None):
set :linked_dirs,  %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public}
# set :linked_files, %w{config/database.yml}
