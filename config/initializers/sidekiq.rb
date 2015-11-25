#initializers/sidekiq.rb
schedule_file = "config/schedule.yml"

Sidekiq.configure_server do |config|
  config.redis = { :url => 'redis://127.0.0.1:6379/0', :namespace => "BURNUP" }
end

# When in Unicorn, this block needs to go in unicorn's `after_fork` callback:
Sidekiq.configure_client do |config|
  config.redis = { :url => 'redis://127.0.0.1:6379/0', :namespace => "BURNUP" }
end


if File.exists?(schedule_file) and file_content = YAML.load_file(schedule_file)
  Sidekiq::Cron::Job.load_from_hash file_content
end

if defined?(PhusionPassenger)
  PhusionPassenger.on_event(:starting_worker_process) do |forked|

    schedule_file = "config/schedule.yml"


    Sidekiq.configure_client do |config|
      config.redis = {  :url => 'redis://127.0.0.1:6379/0', :namespace => "BURNUP", :size => 1 }
    end if forked
    if File.exists?(schedule_file)
      Sidekiq::Cron::Job.load_from_hash YAML.load_file(schedule_file)
    end
  end
end
