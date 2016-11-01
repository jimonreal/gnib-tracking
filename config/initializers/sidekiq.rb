
Sidekiq.configure_server do |config|
	config.redis = { url: 'redis://redis:6379/12' }
end

Sidekiq.configure_client do |config|
	config.redis = { url: 'redis://redis:6379/12' }
end

Typ.all.each do |typ|
  Cat.all.each do |cat|
    cat.sbcats.each do |sbcat|
      Sidekiq::Cron::Job.create(name: "Seeking #{cat.id}-#{sbcat.id}-#{typ.id}", args: {cat_id: cat.id, sbcat_id: sbcat.id, typ_id: typ.id}, cron: '*/15 * * * *', class: 'SeekAvailabilitiesWorker')
    end
  end
end if ENV.has_key? 'MYSQL_ROOT_PASSWORD'
