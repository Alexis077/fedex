class Fedex::Rates 
  def self.get(credentials, quote_params)
    Api::V1::Client.new(credentials, "sandbox").get_rates(quote_params)
  end
end
