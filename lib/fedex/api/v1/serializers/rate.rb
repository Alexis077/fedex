require "nokogiri"

class Fedex::Api::V1::Serializers::Rate
  def initialize(response)
    @response = response
  end

  def execute!
    get_xml_data
  end

  private

  def get_xml_data
    doc = Nokogiri::XML(@response)
    rate_reply_details = doc.xpath('//RateReplyDetails')
    
    rate_reply_details.each do |rrd|
      shipment_rate_detail = rrd.at_xpath('./ShipmentRateDetail')

      currency = shipment_rate_detail.at_xpath('.//TotalNetChargeWithDutiesAndTaxes/Currency').content
      amount = shipment_rate_detail.at_xpath('.//TotalNetChargeWithDutiesAndTaxes/Amount').content
      service_type = rrd.at_xpath('./ServiceType').content

      {price: amount, currency: currency.downcase, service_level: {name: service_type.split("_").join(" ").titleize, token: service_type }}
    end
  end
end
