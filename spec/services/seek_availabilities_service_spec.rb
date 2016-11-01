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
  it 'calls to the site to look availabilities' do

    stub_request(:any, /.*/)

    SeekAvailabilitiesService.new(cat: Cat.first, sbcat: Sbcat.first, typ: Typ.first).call

    expect(WebMock).to have_requested(:get, 'https://burghquayregistrationoffice.inis.gov.ie/Website/AMSREG/AMSRegWeb.nsf/(getAppsNear)').
      with(query: hash_including({openpage: nil, cat: Cat.first.name, sbcat: Sbcat.first.name, typ: Typ.first.name})).once

  end

  context 'when exists availabilities' do
    it 'registers the availabilities' do
      stub_request(:any, /.*/).to_return(body: '{"slots":[{"time":"23 December 2016 - 08:00 AM", "id":"E0E9D13A423F8EDC8025805A001B7B8E"}, {"time":"23 December 2016 - 10:00 AM", "id":"9E0E2ED8425BF7BC8025805A001B7BAE"}]}')

      SeekAvailabilitiesService.new(cat: Cat.first, sbcat: Sbcat.first, typ: Typ.first).call

      availability1 = Availability.where(cat: Cat.first, sbcat: Sbcat.first, typ: Typ.first)[0]
      availability2 = Availability.where(cat: Cat.first, sbcat: Sbcat.first, typ: Typ.first)[1]

      expect(availability1.cat).to eq(Cat.first)
      expect(availability1.sbcat).to eq(Sbcat.first)
      expect(availability1.typ).to eq(Typ.first)
      expect(availability1.datetime).to eq(DateTime.parse("23 December 2016 - 08:00 AM"))

      expect(availability2.cat).to eq(Cat.first)
      expect(availability2.sbcat).to eq(Sbcat.first)
      expect(availability2.typ).to eq(Typ.first)
      expect(availability2.datetime).to eq(DateTime.parse("23 December 2016 - 10:00 AM"))
    end
  end

  context 'when do not exists availabilities' do
    it 'registers the availabilities' do
      stub_request(:any, /.*/).to_return(body: '{"empty":"TRUE"}')

      SeekAvailabilitiesService.new(cat: Cat.first, sbcat: Sbcat.first, typ: Typ.first).call

      expect(Availability.count).to be 0
    end
  end
end
