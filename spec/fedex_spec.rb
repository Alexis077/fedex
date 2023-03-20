# frozen_string_literal: true

require "spec_helper"

RSpec.describe Fedex do
  let!(:credentials) do
    {
      user_credential_key: "bkjIgUhxdghtLw9L",
      user_credential_password: "6p8oOccHmDwuJZCyJs44wQ0Iw",
      account_number: "510087720",
      meter_number: "119238439"
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

  context "with example data" do
    it "success" do
      response = Fedex::Rates.get(credentials, quote_params)
    end
  end
end
