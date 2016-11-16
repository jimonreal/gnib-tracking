require "rails_helper"

describe TrackingMailer, type: :mailer do
  let (:tracking) { create(:tracking_with_availabilities) }

  it 'send a notification email with all availabilities' do
    TrackingMailer.alert(tracking).deliver_now

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    email = ActionMailer::Base.deliveries.first
    expect(email.to).to include(tracking.user.email)
    expect(email.body.raw_source).to include(tracking.user.name)
    expect(email.body.raw_source).to include(tracking.cat.name)
    expect(email.body.raw_source).to include(tracking.typ.name)
    tracking.availabilities.each do |availability|
      expect(email.body.raw_source).to include(I18n.l availability.datetime)
    end
  end

  it "just send notifications about new notifications" do
  	TrackingMailer.alert(tracking).deliver_now
  	
  	tracking.reload

  	create(:availability, cat: tracking.cat, typ: tracking.typ, updated_at: 1.minute.from_now)

  	TrackingMailer.alert(tracking).deliver_now

  	email = ActionMailer::Base.deliveries.last

  	tracking.availabilities[0...-1].each do |availability|
      expect(email.body.raw_source).to_not include(I18n.l availability.datetime)
    end

    expect(email.body.raw_source).to include(I18n.l tracking.availabilities.last.datetime)
  end
end
