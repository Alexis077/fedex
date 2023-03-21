# frozen_string_literal: true

require "nokogiri"
require "httparty"
require "ostruct"
require "dry-validation"
require "active_support/all"
require_relative "fedex/api/v1/sanitizers/rate"
require_relative "fedex/api/v1/serializers/rate"
require_relative "fedex/api/v1/contracts/rate_contract"
require_relative "fedex/api/v1/client"
require_relative "fedex/version"
require_relative "fedex/rates"
require_relative "fedex/error"

module Fedex
end
