# frozen_string_literal: true

module Fedex
  module Api
    module Contracts
      class RateContract < Dry::Validation::Contract
        schema do
          required(:address_from).schema do
            required(:zip).filled(:str?)
            required(:country).filled(:str?)
          end

          required(:address_to).schema do
            required(:zip).filled(:str?)
            required(:country).filled(:str?)
          end

          required(:parcel).schema do
            required(:length).filled(:float?)
            required(:width).filled(:float?)
            required(:height).filled(:float?)
            required(:distance_unit).filled(:str?)
            required(:weight).filled(:float?)
            required(:mass_unit).filled(:str?)
          end
        end
      end
    end
  end
end
