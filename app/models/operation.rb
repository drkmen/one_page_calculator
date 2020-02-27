# frozen_string_literal: true

class Operation
  include Mongoid::Document

  SIGNS = %i[+ - / *].freeze

  field :operation, type: String
  field :result, type: Integer
  field :uid, type: String # would be usefull to identify more complex calculations
  field :count, type: Integer, default: 0

  # should be moved to presenter/serializer
  def as_hash
    {
      id: id.to_s,
      operation: operation,
      result: result,
      count: count
    }
  end
end
