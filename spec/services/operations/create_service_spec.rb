# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Operations::CreateService do
  subject { described_class.perform(params) }

  shared_examples :error_raiser do
    it 'raises an error' do
      expect { subject }.to raise_error ArgumentError, error_message
    end
  end

  describe '.call' do
    let(:arg_a) { 1 }
    let(:arg_b) { 2 }
    let(:commit) { :+ }
    let(:params) do
      {
        arg_a: arg_a,
        arg_b: arg_b,
        commit: commit
      }
    end
    let(:correct_attributes) do
      {
        operation: [arg_a, commit, arg_b].join,
        result: arg_a.public_send(commit, arg_b),
        count: 1
      }
    end

    it 'creates operation' do
      expect { subject }.to change { Operation.count }.by(1)
    end

    it 'and operation has correct attributes' do
      expect(subject.attributes.except(:_id)).to include correct_attributes.stringify_keys
    end

    context 'when same operation already exists' do
      let(:operation) { FactoryBot.create(:operation) }
      let(:arg_a) { 1 }
      let(:arg_b) { 1 }
      let(:commit) { :+ }

      before { allow(Operation).to receive(:find_or_create_by!).and_return(operation) }

      it 'returns operation' do
        expect(subject.id).to eq operation.id
      end

      it 'increments counter' do
        expect(operation).to receive(:inc).with(count: 1)
        subject
      end
    end

    context 'when arg_a' do
      let(:error_message) { '`arg_a` should be positive and less then 100' }

      context 'is missing' do
        let(:arg_a) { nil }

        it_behaves_like :error_raiser
      end

      context 'is invalid' do
        let(:arg_a) { -1 }

        it_behaves_like :error_raiser
      end
    end

    context 'when arg_b' do
      let(:error_message) { '`arg_b` should be positive and less then 100' }

      context 'is missing' do
        let(:arg_b) { nil }

        it_behaves_like :error_raiser
      end

      context 'is invalid' do
        let(:arg_b) { 101 }

        it_behaves_like :error_raiser
      end
    end

    context 'when operation' do
      let(:error_message) { "`operation` can be one of #{Operation::SIGNS}" }

      context 'is missing' do
        let(:commit) { nil }

        it_behaves_like :error_raiser
      end

      context 'is invalid' do
        let(:commit) { nil }

        it_behaves_like :error_raiser
      end
    end
  end
end
