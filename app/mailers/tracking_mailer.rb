class TrackingMailer < ApplicationMailer

  def alert(tracking)
    return unless tracking.active?

    @tracking = tracking

    I18n.with_locale(tracking.user.locale) do
      mail to: @tracking.user.email, subject: I18n.t('tracking_mailer.alert.title') unless @tracking.new_availabilities.empty?
    end
  end

  def welcome(tracking)
    @tracking = tracking

    I18n.with_locale(tracking.user.locale) do
      mail to: @tracking.user.email, subject: I18n.t('tracking_mailer.welcome.title')
    end
  end

end
