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

describe SeekAvailabilitiesService, type: :service do
  let(:cat) { create(:cat) }
  let(:typ) { create(:typ) }

  it 'calls to the site to look availabilities' do

    stub_request(:any, /.*/)

    SeekAvailabilitiesService.new(cat: cat, typ: typ).call

    expect(WebMock).to have_requested(:get, 'https://burghquayregistrationoffice.inis.gov.ie/Website/AMSREG/AMSRegWeb.nsf/(getAppsNear)').
      with(query: hash_including({openpage: nil, cat: cat.name, sbcat: 'All', typ: typ.name})).once

  end

  context 'when exists availabilities' do
    it 'registers the availabilities' do
      stub_request(:any, /.*/).to_return(body: '{"slots":[{"time":"23 December 2016 - 08:00 AM", "id":"E0E9D13A423F8EDC8025805A001B7B8E"}, {"time":"23 December 2016 - 10:00 AM", "id":"9E0E2ED8425BF7BC8025805A001B7BAE"}]}')

      SeekAvailabilitiesService.new(cat: cat, typ: typ).call

      availability1 = Availability.where(cat: cat, typ: typ)[0]
      availability2 = Availability.where(cat: cat, typ: typ)[1]

      expect(availability1.cat).to eq(cat)
      expect(availability1.typ).to eq(typ)
      expect(availability1.datetime).to eq(DateTime.parse("23 December 2016 - 08:00 AM"))

      expect(availability2.cat).to eq(cat)
      expect(availability2.typ).to eq(typ)
      expect(availability2.datetime).to eq(DateTime.parse("23 December 2016 - 10:00 AM"))
    end

    it 'just update the existent availabilities' do
      availability = create(:availability, cat: cat, typ: typ, external_id: 'E0E9D13A423F8EDC8025805A001B7B8E', datetime: DateTime.parse("23 December 2016 - 08:00 AM"))

      stub_request(:any, /.*/).to_return(body: '{"slots":[{"time":"23 December 2016 - 08:00 AM", "id":"E0E9D13A423F8EDC8025805A001B7B8E"}, {"time":"23 December 2016 - 10:00 AM", "id":"9E0E2ED8425BF7BC8025805A001B7BAE"}]}')

      expect{ SeekAvailabilitiesService.new(cat: cat, typ: typ).call }.to change{ Availability.count }.from(1).to(2)
      expect(availability.reload.expired).to be false
    end
  end

  context 'when do not exists availabilities' do
    it 'does not register the availabilities' do
      stub_request(:any, /.*/).to_return(body: '{"empty":"TRUE"}')

      SeekAvailabilitiesService.new(cat: cat, typ: typ).call

      expect(Availability.count).to be 0
    end

    it 'expires the last availabilities that matches id' do
      stub_request(:any, /.*/).to_return(body: '{"empty":"TRUE"}')

      availability1 = FactoryGirl.create(:availability, cat: cat, typ: typ)
      availability2 = FactoryGirl.create(:availability, cat: create(:cat), typ: typ)

      SeekAvailabilitiesService.new(cat: cat, typ: typ).call

      expect(availability1.reload.expired).to be true
      expect(availability2.reload.expired).to be false
    end
  end
end
