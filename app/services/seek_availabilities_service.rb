class SeekAvailabilitiesService

  def initialize(cat:,sbcat:,typ:)
    @cat, @sbcat, @typ = cat, sbcat, typ 
  end

  def call
    uri = URI("https://burghquayregistrationoffice.inis.gov.ie/Website/AMSREG/AMSRegWeb.nsf/(getAppsNear)")
    uri.query = URI.encode_www_form openpage: nil, cat: @cat.name, sbcat: @sbcat.name, typ: @typ.name
    http = Net::HTTP.new(uri.host, uri.port)
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE
    http.use_ssl = true
    res = http.get(uri.request_uri)

    if res.body.present?
      json = JSON.parse(res.body) 
      json['slots'].each do |data|
        Availability.create! cat: @cat, sbcat: @sbcat, typ: @typ, datetime: DateTime.parse(data['time'])
      end if json.has_key? 'slots'
    end
  end
end
