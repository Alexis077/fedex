# frozen_string_literal: true

require "spec_helper"

RSpec.describe Fedex do
  let!(:credentials) do
    {
      user_credential_key: "bkjIgUhxdghtLw9L",
      user_credential_password: "6p8oOccHmDwuJZCyJs44wQ0Iw",
      account_number: "510087720",
      meter_number: "119238439",
      environment: "sandbox"
    }
  end

  let!(:quote_params) do
    {
      address_from: {
        zip: "64000",
        country: "MX"
      },
      address_to: {
        zip: "64000",
        country: "MX"
      },
      parcel: {
        length: 25.0,
        width: 28.0,
        height: 46.0,
        distance_unit: "cm",
        weight: 6.5,
        mass_unit: "kg"
      }
    }
  end

  context "with normal data" do
    it "success" do
      VCR.use_cassette "rates" do
        rates = Fedex::Rates.get(credentials, quote_params)
        expect(rates.size).to be > 1
        rates.each do |rate|
          expect(rate[:price]).not_to be_nil
          expect(rate[:currency]).to eq("mxn")
          expect(rate[:service_level][:name]).not_to be_nil
          expect(rate[:service_level][:token]).not_to be_nil
        end
      end
    end
  end

  context "with missing data" do
    it "failure" do
      VCR.use_cassette "rates_failure_with_missing_data" do
        quote_params[:address_to] = nil
        rates = Fedex::Rates.get(credentials, quote_params)
        expect(rates.message).not_to be_nil
      end
    end
  end

  context "with wring data" do
    it "failure" do
      VCR.use_cassette "rates_failure_with_wrong_data" do
        quote_params[:parcel][:mass_unit] = "bg"
        rates = Fedex::Rates.get(credentials, quote_params)
        expect(rates.message).not_to be_nil
      end
    end
  end
end
