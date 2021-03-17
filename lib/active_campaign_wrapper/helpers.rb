# frozen_string_literal: true

require 'active_support/core_ext/string'

module ActiveCampaignWrapper
  module Helpers
    def normalize_response(response)
      raise ActiveCampaignWrapper::AuthorizationError.new(response.message) if response.code == 403
      raise ActiveCampaignWrapper::Error.new(response.message) if [200, 201, 202].exclude?(response.code)

      transform_keys(response, :underscore)
    end

    def normalize_body(args)
      return unless args[1].is_a?(Hash)

      args[1].merge!(
        body: transform_keys(
          args[1][:body] || {},
          :camelcase, :lower
        ).to_json
      )
      args
    end

    # Transforms case of all hash keys
    # @note this is used to always output a hash response
    #
    # @param [Hash] hash initial hash before transformation
    # @param [Symbol, Symbol] :underscore or [:camelcase, :lower]  DEFAULT: underscore
    # @return [Hash]
    #
    def transform_keys(hash, *case_style)
      hash.each_with_object({}) do |(key, value), memo|
        memo[transform_key(key, *case_style)] = transform_value(value, *case_style)
      end
    end

    #
    # Transform the provided keys case and lastly symbolize it
    #
    # @param [String, Symbol] key the name of the key to change case
    # @param [Symbol, Symbol]
    # @return [Symbol] the transformed key
    #
    def transform_key(key, *case_style)
      key.to_s.public_send(*case_style).to_sym
    end

    #
    # Transform all values
    # @note used for nested values like hashes and arrays
    #
    # @param [Object] value the value to transform
    # @param [Symbol, Symbol] :underscore or [:camelcase, :lower]  DEFAULT: underscore
    # @return [Object]
    #
    def transform_value(value, *case_style)
      case value
      when Hash
        transform_keys(value, *case_style)
      when Array
        transform_array(value, *case_style)
      else
        value
      end
    end

    def transform_array(collection, *case_style)
      collection.map do |element|
        case element
        when Hash
          transform_keys(element, *case_style)
        else
          element
        end
      end
    end
  end
end
