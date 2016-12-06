require "rails_helper"

describe TrackingMailer, type: :mailer do
  let (:tracking) { create(:tracking_with_availabilities) }

  describe "Welcome email" do
    it do
      tracking = create(:tracking)

      TrackingMailer.welcome(tracking).deliver_now

      expect(ActionMailer::Base.deliveries.count).to eq(1)
      email = ActionMailer::Base.deliveries.first
      expect(email.to).to include(tracking.user.email)
      expect(email.body.raw_source).to include(tracking.user.name)
      expect(email.body.raw_source).to include(tracking.cat.name)
      expect(email.body.raw_source).to include(tracking.typ.name)
      expect(email.body.raw_source).to include(deregister_tracking_url tracking.token)
    end

    context 'when has unexpired availabilities' do
      it do
        tracking = create(:tracking_with_availabilities)
        tracking.availabilities[0].update expired_at: Time.now

        TrackingMailer.welcome(tracking).deliver_now

        email = ActionMailer::Base.deliveries.first

        I18n.with_locale(tracking.user.locale) do
          tracking.new_availabilities.unexpired.each do |availability|
            expect(email.body.raw_source).to include(I18n.l availability.datetime)
          end

          tracking.new_availabilities.expired.each do |availability|
            expect(email.body.raw_source).to_not include(I18n.l availability.datetime)
          end
        end

        expect(email.body.raw_source).to include('https://burghquayregistrationoffice.inis.gov.ie/')
      end
    end
  end

  it 'send a notification email with all availabilities' do
    TrackingMailer.alert(tracking).deliver_now

    expect(ActionMailer::Base.deliveries.count).to eq(1)
    email = ActionMailer::Base.deliveries.first
    expect(email.to).to include(tracking.user.email)
    expect(email.body.raw_source).to include(tracking.user.name)
    expect(email.body.raw_source).to include(tracking.cat.name)
    expect(email.body.raw_source).to include(tracking.typ.name)
    expect(email.body.raw_source).to include('https://burghquayregistrationoffice.inis.gov.ie/')
    expect(email.body.raw_source).to include(deregister_tracking_url tracking.token)
    
    I18n.with_locale(tracking.user.locale) do
      tracking.availabilities.each do |availability|
        expect(email.body.raw_source).to include(I18n.l availability.datetime)
      end
    end
  end

  it "just send notifications about new availabilities" do
    tracking.mark_as_notified!

    create(:availability, cat: tracking.cat, typ: tracking.typ, updated_at: 1.minute.from_now, datetime: 1.minute.from_now)

    TrackingMailer.alert(tracking).deliver_now

    email = ActionMailer::Base.deliveries.last

    I18n.with_locale(tracking.user.locale) do
      tracking.availabilities[0...-1].each do |availability|
        expect(email.body.raw_source).to_not include(I18n.l availability.datetime)
      end

      expect(email.body.raw_source).to include(I18n.l tracking.availabilities.last.datetime)
    end
  end

  it "don't send notifications if there is no availability" do
    tracking = create(:tracking)
    
    TrackingMailer.alert(tracking).deliver_now

    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end

  it "don't send notifications if the tracking is inactive" do
    tracking = create(:tracking_with_availabilities, active: false)
    
    TrackingMailer.alert(tracking).deliver_now

    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end

end
