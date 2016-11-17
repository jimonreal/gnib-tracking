class TrackingMailer < ApplicationMailer

  def alert(tracking)
    @tracking = tracking

    mail to: @tracking.user.email, subject: 'New Appointments Available' unless @tracking.new_availabilities.empty?
  end

  def welcome(tracking)
    @tracking = tracking

    mail to: @tracking.user.email, subject: 'A new tracking has been created'
  end

end
