# frozen_string_literal: true

FactoryBot.define do
  factory :operation do
    operation { '1+1' }
    result { 2 }
  end
end
