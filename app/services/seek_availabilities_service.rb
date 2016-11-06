class SeekAvailabilitiesService

  def initialize(cat:,typ:)
    @cat, @typ = cat, typ 
  end

  def call
    uri = URI("https://burghquayregistrationoffice.inis.gov.ie/Website/AMSREG/AMSRegWeb.nsf/(getAppsNear)")
    uri.query = URI.encode_www_form openpage: nil, cat: @cat.name, sbcat: 'All', typ: @typ.name
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    res = http.get(uri.request_uri)

    if res.body.present?
      Availability.where(cat: @cat, typ: @typ).update_all(expired: true)
      json = JSON.parse(res.body) 
      json['slots'].each do |data|
        Availability.create!(cat: @cat, typ: @typ, datetime: DateTime.parse(data['time'])) unless Availability.where(external_id: data['id']).exists?
      end if json.has_key? 'slots'
    end
  end
end
