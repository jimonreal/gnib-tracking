class TrackingMailer < ApplicationMailer

  def alert(tracking)
    @tracking = tracking

    mail to: @tracking.user.email, subject: 'New Appointments Available'
  end

end
