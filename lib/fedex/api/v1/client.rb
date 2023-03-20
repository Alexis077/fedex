# frozen_string_literal: true

module Fedex
  module Api
    module V1
      class Client
        ENVIRONMENTS = {
          "production" => "https://ws.fedex.com:443/xml",
          "sandbox" => "https://wsbeta.fedex.com:443/xml"
        }.freeze
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
          response = HTTParty.post(ENVIRONMENTS[@environment], body: xml_data,
                                                               headers: { "Content-type" => "application/xml" })
          raise Error.new(message: response["CSRError"]["message"]) unless response.success?

          Serializers::Rate.new(response.body).execute!
        rescue StandardError => e
          Error.new(message: e.message)
        end
      end
    end
  end
end
