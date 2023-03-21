# frozen_string_literal: true

module Fedex
  module Api
    module V1
      class Client
        ENVIRONMENTS = {
          "production" => "https://ws.fedex.com:443/xml",
          "sandbox" => "https://wsbeta.fedex.com:443/xml"
        }.freeze
        def initialize(credentials)
          @credentials = HashWithIndifferentAccess.new(credentials)
        end

        def get_rates(payload)
          rates_payload = HashWithIndifferentAccess.new(payload)
          rate_contract = Contracts::RateContract.new
          rate_contract_result = rate_contract.call(rates_payload)

          raise Error.new(message: rate_contract_result.errors.to_h) unless rate_contract_result.success?

          sanitizer = Sanitizers::Rate.new(
            @credentials,
            rates_payload
          )
          xml_data = sanitizer.execute!

          response = HTTParty.post((ENVIRONMENTS[@credentials[:environment]] || "sandbox"), body: xml_data,
                                                                                            headers: { "Content-type" => "application/xml" })
          raise Error.new(message: response["CSRError"]["message"]) unless response.success?

          Serializers::Rate.new(response.body).execute!
        rescue => ex
          OpenStruct.new(message: ex.message)
        end
      end
    end
  end
end
