# frozen_string_literal: true

require "nokogiri"
require "httparty"
require "cgi"
require "savon"
require_relative "fedex/api/v1/sanitizers/rate.rb"
require_relative "fedex/api/v1/serializers/rate.rb"
require_relative "fedex/api/v1/serializers/rate.rb"
require_relative "fedex/api/v1/client.rb"
require_relative "fedex/version"
require_relative "fedex/rates.rb"


module Fedex
  class Error < StandardError; end
  # Your code goes here...
end
