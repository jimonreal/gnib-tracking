# == Schema Information
#
# Table name: availabilities
#
#  id         :integer          not null, primary key
#  count      :integer
#  cat_id     :integer
#  sbcat_id   :integer
#  typ_id     :integer
#  datetime   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

describe NotifyTrackingsService, type: :service do

  let(:cat) { create(:cat) }
  let(:typ) { create(:typ) }
  let(:mail) do
    mail = instance_double(ActionMailer::MessageDelivery)
    allow(mail).to receive(:deliver_later)
    mail
  end

  it "send notifications for all trackings" do
    trackings = create_list(:tracking_with_availabilities, 2, cat: cat, typ: typ)

    expect(TrackingMailer).to receive(:alert).exactly(2).times { mail }
    expect(mail).to receive(:deliver_later).exactly(2).times

    NotifyTrackingsService.new(cat: cat, typ: typ).call
  end

  context 'when the tracking is for earlier' do
    context 'and appointment date is later' do
      it do
        tracking = create(:tracking, cat: cat, typ: typ, date_behavior: :earlier, end_date: 3.days.from_now)
        availability = create(:availability, cat: cat, typ: typ, datetime: 4.days.from_now)

        expect(TrackingMailer).to receive(:alert).exactly(0).times

        NotifyTrackingsService.new(cat: cat, typ: typ).call
      end
    end

    context 'and appointment date is in the same day' do
      it do
        tracking = create(:tracking, cat: cat, typ: typ, date_behavior: :earlier, end_date: 3.days.from_now)
        availability = create(:availability, cat: cat, typ: typ, datetime: 3.days.from_now)

        expect(TrackingMailer).to receive(:alert).exactly(0).times

        NotifyTrackingsService.new(cat: cat, typ: typ).call
      end
    end

    context 'and appointment date is before' do
      it do
        tracking = create(:tracking, cat: cat, typ: typ, date_behavior: :earlier, end_date: 3.days.from_now)
        availability = create(:availability, cat: cat, typ: typ, datetime: 2.days.from_now)

        expect(TrackingMailer).to receive(:alert).exactly(1).times { mail }

        NotifyTrackingsService.new(cat: cat, typ: typ).call
      end
    end
  end


  context 'when the tracking is for later date' do
    context 'and appointment date is earlier' do
      it do
        tracking = create(:tracking, cat: cat, typ: typ, date_behavior: :later, begin_date: 1.day.from_now)
        availability = create(:availability, cat: cat, typ: typ, datetime: Date.today)

        expect(TrackingMailer).to receive(:alert).exactly(0).times

        NotifyTrackingsService.new(cat: cat, typ: typ).call
      end
    end

    context 'and appointment date is in the same day' do
      it do
        tracking = create(:tracking, cat: cat, typ: typ, date_behavior: :later, begin_date: Date.today)
        availability = create(:availability, cat: cat, typ: typ, datetime: Date.today)

        expect(TrackingMailer).to receive(:alert).exactly(1).times { mail }

        NotifyTrackingsService.new(cat: cat, typ: typ).call
      end
    end

    context 'and appointment date is after' do
      it do
        tracking = create(:tracking, cat: cat, typ: typ, date_behavior: :later, begin_date: Date.today)
        availability = create(:availability, cat: cat, typ: typ, datetime: 1.day.from_now)

        expect(TrackingMailer).to receive(:alert).exactly(1).times { mail }

        NotifyTrackingsService.new(cat: cat, typ: typ).call
      end
    end
  end


  it "doesn't send notifications twice" do
    tracking = create(:tracking_with_availabilities, cat: cat, typ: typ)

    # first call
    expect(TrackingMailer).to receive(:alert) { mail }
    NotifyTrackingsService.new(cat: cat, typ: typ).call

    # second call
    expect(TrackingMailer).to_not receive(:alert)
    NotifyTrackingsService.new(cat: cat, typ: typ).call
  end

end