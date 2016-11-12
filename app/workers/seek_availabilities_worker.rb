class SeekAvailabilitiesWorker
  include Sidekiq::Worker

  def perform(data)
  	cat = Cat.find(data['cat_id'])
  	typ = Typ.find(data['typ_id'])
    
    SeekAvailabilitiesService.new(
      cat: cat,
    	typ: typ
    ).call

    Tracking.where(cat: cat, typ: typ).activated.each do |tracking|
    	AvailabilityMailer.alert(tracking).deliver_later unless tracking.new_availabilities.empty?
    end
  end
end
