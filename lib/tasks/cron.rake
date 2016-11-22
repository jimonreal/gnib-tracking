namespace :cron do
  desc "TODO"
  task setup: :environment do
    if Rails.env.production?
    	ActiveRecord::Base.logger.silence do
      	Typ.all.each do |typ|
          Cat.all.each do |cat|
            Sidekiq::Cron::Job.create(name: "Seeking #{cat.name} - #{typ.name}", args: [cat.id, typ.id], cron: '*/5 * * * *', class: 'SeekAvailabilitiesWorker')
          end
        end
      end
    end
  end
end
