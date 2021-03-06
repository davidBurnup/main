# config valid only for current version of Capistrano
lock "3.9.0"

set :application, "burnup"
# set :repo_url, "git@github.com:davidfabreguette/burnup.git"
set :repo_url, "git@github.com:davidBurnup/main.git"
# set :repo_url, "git@vps359095.ovh.net:root/burnup.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/var/www/burnup.fr"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/sidekiq.yml", "config/cable.yml"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Restart Passenger using touch tmp/restart.txt
set :passenger_restart_with_touch, true

set :assets_roles, [:web, :app]


# Rake::Task['deploy:assets:precompile'].clear

# namespace :deploy do
#   namespace :assets do
#     desc 'Precompile assets locally and then rsync to remote servers'
#     task :precompile do
#       local_manifest_path = %x{ls public/assets/manifest*}.strip

#       %x{bundle exec rake assets:precompile assets:clean}

#       on roles(fetch(:assets_roles)) do |server|
#         %x{rsync -av ./public/assets/ #{server.user}@#{server.hostname}:#{release_path}/public/assets/}
#         %x{rsync -av ./#{local_manifest_path} #{server.user}@#{server.hostname}:#{release_path}/assets_manifest#{File.extname(local_manifest_path)}}
#       end

#       %x{bundle exec rake assets:clobber}
#     end
#   end
# end
