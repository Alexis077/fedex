# frozen_string_literal: true

require "nokogiri"
require "httparty"
require_relative "fedex/api/v1/sanitizers/rate"
require_relative "fedex/api/v1/serializers/rate"
require_relative "fedex/api/v1/client"
require_relative "fedex/version"
require_relative "fedex/rates"

module Fedex
  class Error < StandardError; end
  # Your code goes here...
end
