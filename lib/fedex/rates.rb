# frozen_string_literal: true

module Fedex
  class Rates
    def self.get(credentials, quote_params)
      Api::V1::Client.new(credentials).get_rates(quote_params)
    end
  end
end
