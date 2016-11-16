class NotifyTrackingsService

  def initialize(cat:,typ:)
    @cat, @typ = cat, typ 
  end

  def call
    Tracking.where(cat: @cat, typ: @typ).each do |tracking|
      next if tracking.new_availabilities.empty?
      
      TrackingMailer.alert(tracking).deliver_later
      tracking.mark_as_notified!
    end
  end
end
