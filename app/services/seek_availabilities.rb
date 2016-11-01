class SeekAvailabilities
  def call(cat:,sbcat:,typ:)
    uri = URI("https://burghquayregistrationoffice.inis.gov.ie/")
    uri.query = URI.encode_www_form cat: cat.name, sbcat: sbcat.name, typ: typ.name
    res = Net::HTTP.get_response(uri)

    if res.body.present?
      json = JSON.parse(res.body) 
      json['slots'].each do |data|
        Availability.create! cat: cat, sbcat: sbcat, typ: typ, datetime: DateTime.parse(data['time'])
      end
    end
  end
end