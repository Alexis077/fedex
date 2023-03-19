class Fedex::Api::V1::Client
  ENVIRONMENTS = {
    "production" => "https://ws.fedex.com:443/xml",
    "sandbox" => "https://wsbeta.fedex.com:443/xml"
  }
  def initialize(credentials, environment)
    @credentials = credentials
    @environment = environment
  end

  def get_rates(payload)
    sanitizer = Sanitizers::Rate.new(
      @credentials,
      payload
    )
    xml_data = sanitizer.execute!
    response = HTTParty.post(ENVIRONMENTS[@environment], body: xml_data)
    response.body
  end
end
