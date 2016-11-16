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
      next unless tracking.new_availabilities.present?
    	TrackingMailer.alert(tracking).deliver_later and tracking.mark_as_notified!
    end
  end
end
