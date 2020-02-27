# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operation, type: :model do
  subject(:operation) { FactoryBot.build(:operation) }

  it { is_expected.to be_mongoid_document }

  describe 'fields' do
    it { is_expected.to have_field(:operation).of_type(String) }
    it { is_expected.to have_field(:result).of_type(Integer) }
    it { is_expected.to have_field(:uid).of_type(String) }
    it { is_expected.to have_field(:count).of_type(Integer).with_default_value_of(0) }
  end

  describe 'constants' do
    describe 'SIGNS' do
      subject { described_class::SIGNS }

      it { is_expected.to contain_exactly(*%i[+ - / *]) }
    end
  end

  describe 'methods' do
    describe '.as_hash' do
      let(:expected_attributes) do
        {
          id: operation.id.to_s,
          operation: operation.operation,
          result: operation.result,
          count: operation.count
        }
      end

      subject { operation.as_hash }

      it { is_expected.to eq expected_attributes }
    end
  end
end
