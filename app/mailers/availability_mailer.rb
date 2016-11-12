class AvailabilityMailer < ApplicationMailer

  def alert(tracking)
    @tracking = tracking

    mail to: @tracking.user.email, subject: 'New Appointments Available'

    @tracking.update! last_notification_at: DateTime.now
  end

end
