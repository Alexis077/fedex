# frozen_string_literal: true

class Error < StandardError
  attr_accessor :response

  def initialize(response: {}, message: "")
    @response = response
    super(message)
  end
end
