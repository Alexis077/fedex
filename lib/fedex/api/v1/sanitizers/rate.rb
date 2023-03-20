# frozen_string_literal: true

module Fedex
  module Api
    module V1
      module Sanitizers
        class Rate
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
                    xml.LanguageCode "es"
                    xml.LocaleCode "mx"
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
                      xml.StreetLines ""
                      xml.City ""
                      xml.StateOrProvinceCode "XX"
                      xml.PostalCode @data[:address_from][:zip]
                      xml.CountryCode @data[:address_from][:country]
                    end
                  end
                  xml.Recipient do
                    xml.Address do
                      xml.StreetLines ""
                      xml.City ""
                      xml.StateOrProvinceCode "XX"
                      xml.PostalCode @data[:address_to][:zip]
                      xml.CountryCode @data[:address_to][:country]
                      xml.Residential "false"
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
                      xml.Units @data[:parcel][:mass_unit].upcase
                      xml.Value @data[:parcel][:weight]
                    end
                    xml.Dimensions do
                      xml.Length @data[:parcel][:length].to_i
                      xml.Width @data[:parcel][:width].to_i
                      xml.Height @data[:parcel][:height].to_i
                      xml.Units @data[:parcel][:distance_unit].upcase
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
