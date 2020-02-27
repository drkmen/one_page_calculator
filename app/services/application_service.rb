# frozen_string_literal: true

class ApplicationService
  def self.perform(params = {}, &block)
    new(params).call(&block)
  end

  def initialize(params = {})
    @params = params
  end

  def call; end

  private

  attr_reader :params
end
