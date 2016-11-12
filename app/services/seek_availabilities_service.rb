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
      json = JSON.parse(res.body) 
      valids = []
      if json.has_key? 'slots'
        json['slots'].each do |data|
          slot =  Availability.where(external_id: data['id']).first ||
                  Availability.create!(
                    external_id: data['id'],
                    cat: @cat,
                    typ: @typ,
                    datetime: DateTime.parse(data['time'])
                  )
          valids << slot
        end
      end
      Availability.where(cat: @cat, typ: @typ).where.not(id: valids).update_all(expired: true)
    end
  end
end
