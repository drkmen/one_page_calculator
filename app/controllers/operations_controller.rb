# frozen_string_literal: true

class OperationsController < ApplicationController
  def index; end

  def create
    operation = Operations::CreateService.perform(operation_params)
    @result = operation.as_hash

    respond_to do |format|
      format.js
    end
  end

  private

  def operation_params
    params.permit(:arg_a, :arg_b, :commit)
  end
end
