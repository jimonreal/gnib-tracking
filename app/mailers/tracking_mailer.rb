class TrackingMailer < ApplicationMailer

  def alert(tracking)
    @tracking = tracking

    mail to: @tracking.user.email, subject: 'New Appointments Available'
  end

  def welcome(tracking)
    @tracking = tracking

    mail to: @tracking.user.email, subject: 'A new tracking has been created'
  end

end
