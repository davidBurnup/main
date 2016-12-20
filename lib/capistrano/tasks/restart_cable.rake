namespace :cable do
  desc 'restart'
  task :restart do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute "pkill -2 cable && ./bin/cable"
        end
      end
    end
  end
end
