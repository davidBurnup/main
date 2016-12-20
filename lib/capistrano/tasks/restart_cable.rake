namespace :cable do
  desc 'restart'
  task :restart do
    on roles(:app) do
      within "#{current_path}" do
        with rails_env: "#{fetch(:stage)}" do
          execute :rake, "db:create"
        end
      end
    end
  end
end
