# frozen_string_literal: true

module Fedex
  module Api
    module V1
      module Serializers
        class Rate
          def initialize(response)
            @response = response
          end

          def execute!
            get_xml_data
          end

          private

          def get_xml_data
            doc = Nokogiri::XML(@response)
            rate_reply_details = doc.css("RateReply RateReplyDetails")
            rates = []
            rate_reply_details.each do |rrd|
              
              next if rrd.css("ServiceType").first.nil?

              shipment_rate_detail = rrd.css("RatedShipmentDetails").last
              currency = shipment_rate_detail.css("TotalNetChargeWithDutiesAndTaxes Currency").text
              amount = shipment_rate_detail.css("TotalNetChargeWithDutiesAndTaxes Amount").text

              service_type = rrd.css("ServiceType").first.text

              rates << {
                price: amount,
                currency: currency.downcase,
                service_level: {
                  name: service_type.downcase.split("_").map!(&:capitalize).join(" "),
                  token: service_type
                }
              }
            end
            rates
          end
        end
      end
    end
  end
end
