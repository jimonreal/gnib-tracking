class SeekAvailabilitiesWorker
  include Sidekiq::Worker
  include RedisMutex::Macro

  auto_mutex :perform, on: [:cat_id, :typ_id]

  def perform(cat_id, typ_id)
  	cat = Cat.find cat_id
  	typ = Typ.find typ_id
    
    SeekAvailabilitiesService.new(
      cat: cat,
    	typ: typ
    ).call

    NotifyTrackingsService.new(
      cat: cat,
      typ: typ
    ).call
  end
end
