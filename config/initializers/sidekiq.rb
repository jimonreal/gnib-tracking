
Sidekiq.configure_server do |config|
	config.redis = { url: 'redis://redis:6379/12' }
end

Sidekiq.configure_client do |config|
	config.redis = { url: 'redis://redis:6379/12' }
end

Sidekiq::Cron::Job.load_from_hash YAML.load_file('config/schedule.yml') if Sidekiq.server?