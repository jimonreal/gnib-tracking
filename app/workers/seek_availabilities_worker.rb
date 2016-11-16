class SeekAvailabilitiesWorker
  include Sidekiq::Worker

  def perform(data)
  	cat = Cat.find(data['cat_id'])
  	typ = Typ.find(data['typ_id'])
    
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
