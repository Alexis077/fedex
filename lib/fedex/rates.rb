module Fedex
  class Rates
    def self.get(credentials, quote_params)
      response = Api::V1::Client.new(credentials, "sandbox").get_rates(quote_params)
    
    end
  end
end
