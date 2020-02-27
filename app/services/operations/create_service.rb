# frozen_string_literal: true

module Operations
  class CreateService < ApplicationService
    # @attr_reader params [Hash]:d
    # - arg_a: [Integer]
    # - arg_b: [Integer]
    # - operation: [String]

    def call
      validate_params!

      operation_representation = [arg_a_param, operation, arg_b_param].join
      result = arg_a_param.public_send(operation, arg_b_param)
      operation = Operation.find_or_create_by!(operation: operation_representation) do |operation|
        operation.result = result
      end
      operation.inc(count: 1)
      operation
    end

    private

    def validate_params!
      raise ArgumentError, '`arg_a` should be positive and less then 100' unless param_valid?(arg_a_param)
      raise ArgumentError, '`arg_b` should be positive and less then 100' unless param_valid?(arg_b_param)
      raise ArgumentError, "`operation` can be one of #{Operation::SIGNS}" unless Operation::SIGNS.include?(operation)
    end

    def param_valid?(param)
      param&.positive? && param < 100
    end

    def arg_a_param
      params[:arg_a].presence&.to_i
    end

    def arg_b_param
      params[:arg_b].presence&.to_i
    end

    def operation
      params[:commit].presence&.to_sym
    end
  end
end
