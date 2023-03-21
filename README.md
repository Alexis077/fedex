# Fedex
The Fedex gem is a Ruby library that allows you to retrieve shipping rates for a given shipment by providing two addresses. It requires authentication credentials to access the Fedex API and returns a list of available shipping options with their corresponding prices.

## Installation

Add this line to your application's Gemfile:

`gem 'fedex'`

And then execute:

`bundle`

Or install it yourself as:

`gem install fedex`


## Usage

To retrieve shipping rates for a shipment, call the `get` method of the `Fedex::Rates` class and provide it with the required credentials and shipment details. Here's an example:

```ruby 

require 'fedex'

credentials = {
  user_credential_key: "XXXXXXXXXXXXX",
  user_credential_password: "XXXXXXXXXXXXX",
  account_number: "XXXXXXXXXXXXX",
  meter_number: "XXXXXXXXXXXXX",
  environment: "sandbox"
}

shipment_details = {
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

rates = Fedex::Rates.get(credentials, shipment_details)

puts rates.to_s

```
This will output a list of available shipping options with their corresponding prices in the selected currency, as well as the name and token of the service level. Here's an example:

```ruby
[
  {
    price: "524.71",
    currency: "mxn",
    service_level: {
      name: "Priority Overnight",
      token: "PRIORITY_OVERNIGHT"
    }
  },
  {
    price: "418.49",
    currency: "mxn",
    service_level: {
      name: "Standard Overnight",
      token: "STANDARD_OVERNIGHT"
    }
  },
  {
    price: "266.16",
    currency: "mxn",
    service_level: {
      name: "Fedex Express Saver",
      token: "FEDEX_EXPRESS_SAVER"
    }
  }
]

```