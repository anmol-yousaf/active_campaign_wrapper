# frozen_string_literal: true

require 'active_support/core_ext/string'

module ActiveCampaignWrapper
  module Helpers
    module_function

    def normalize_response(response)
      raise ActiveCampaignWrapper::Forbidden, response['message'] if response.forbidden?
      raise ActiveCampaignWrapper::NotFound, response['message'] if response.not_found?
      raise ActiveCampaignWrapper::UnprocessableEntity, response['errors']&.join(', ') || response['error'] if response.unprocessable_entity?
      raise ActiveCampaignWrapper::TooManyRequests, response['message'] if response.too_many_requests?
      raise ActiveCampaignWrapper::Error, response['message'] unless response.success?

      if response&.body.present?
        transform_keys(response, [:underscore])
      else
        {}
      end
    end

    def normalize_body(params, skip_normalization = [])
      return unless params.is_a?(Hash)

      params = transform_keys(
        params || {},
        %i[camelcase lower],
        skip_normalization
      )
      params.to_json
    end

    # Transforms case of all hash keys
    # @note this is used to always output a hash response
    #
    # @param [Hash] hash initial hash before transformation
    # @param [Symbol, Symbol] [:underscore] or [:camelcase, :lower]  DEFAULT: underscore
    # @return [Hash]
    #
    def transform_keys(hash, case_style, skip_normalization = [])
      hash.each_with_object({}) do |(key, value), memo|
        memo[transform_key(key, case_style, skip_normalization)] = transform_value(value, case_style, skip_normalization)
      end
    end

    #
    # Transform the provided keys case and lastly symbolize it
    #
    # @param [String, Symbol] key the name of the key to change case
    # @param [Symbol, Symbol] [:underscore] or [:camelcase, :lower]  DEFAULT: underscore
    # @return [Symbol] the transformed key
    #
    def transform_key(key, case_style, skip_normalization = [])
      unless skip_normalization.include?(key)
        key = key.to_s.public_send(*case_style)
      end
      key.to_sym
    end

    #
    # Transform all values
    # @note used for nested values like hashes and arrays
    #
    # @param [Object] value the value to transform
    # @param [Symbol, Symbol] [:underscore] or [:camelcase, :lower]  DEFAULT: underscore
    # @return [Object]
    #
    def transform_value(value, case_style, skip_normalization = [])
      case value
      when Hash
        transform_keys(value, case_style, skip_normalization)
      when Array
        transform_array(value, case_style, skip_normalization)
      else
        value
      end
    end

    def transform_array(collection, case_style, skip_normalization = [])
      collection.map do |element|
        case element
        when Hash
          transform_keys(element, case_style, skip_normalization)
        else
          element
        end
      end
    end
  end
end
