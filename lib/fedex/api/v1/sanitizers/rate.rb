require "nokogiri"

class Fedex::Api::V1::Sanitizers::Rate
  def initialize(credentials, data)
    @credentials = credentials
    @data = data
  end

  def execute!
    build_xml.to_xml
  end

  private

  def build_xml
    Nokogiri::XML::Builder.new do |xml|
      xml.RateRequest("xmlns" => "http://fedex.com/ws/rate/v13") do
        xml.WebAuthenticationDetail do
          xml.UserCredential do
            xml.Key @credentials[:user_credential_key]
            xml.Password @credentials[:user_credential_password]
          end
        end
        xml.ClientDetail do
          xml.AccountNumber @credentials[:account_number]
          xml.MeterNumber @credentials[:meter_number]
          xml.Localization do
            xml.LanguageCode @data[:language_code]
            xml.LocaleCode @data[:locale_code]
          end
        end
        xml.Version do
          xml.ServiceId "crs"
          xml.Major "13"
          xml.Intermediate "0"
          xml.Minor "0"
        end
        xml.ReturnTransitAndCommit "true"
        xml.RequestedShipment do
          xml.DropoffType "REGULAR_PICKUP"
          xml.PackagingType "YOUR_PACKAGING"
          xml.Shipper do
            xml.Address do
              xml.StreetLines @data[:shipper_street_lines]
              xml.City @data[:shipper_city]
              xml.StateOrProvinceCode @data[:state_or_province_code]
              xml.PostalCode @data[:shipper_postal_code]
              xml.CountryCode @data[:shipper_country_code]
            end
          end
          xml.Recipient do
            xml.Address do
              xml.StreetLines @data[:recipient_street_lines]
              xml.City @data[:recipient_city]
              xml.StateOrProvinceCode @data[:recipient_state_or_province_code]
              xml.PostalCode @data[:recipient_postal_code]
              xml.CountryCode @data[:recipient_country_code]
              xml.Residential @data[:recipient_residential]
            end
          end
          xml.ShippingChargesPayment do
            xml.PaymentType "SENDER"
          end
          xml.RateRequestTypes "ACCOUNT"
          xml.PackageCount "1"
          xml.RequestedPackageLineItems do
            xml.GroupPackageCount "1"
            xml.Weight do
              xml.Units "KG"
              xml.Value @data[:weight_value]
            end
            xml.Dimensions do
              xml.Length @data[:dimensions_length]
              xml.Width @data[:dimensions_width]
              xml.Height @data[:dimensions_height]
              xml.Units "CM"
            end
          end
        end
      end
    end
  end
end
