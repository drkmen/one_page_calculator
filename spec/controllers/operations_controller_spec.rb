# frozen_string_literal: true

require 'rails_helper'

describe OperationsController, type: :controller do
  render_views

  let(:strong_params) { ActionController::Parameters.new(request_params) }

  describe 'GET#index' do
    subject(:response) { get :index  }

    it { is_expected.to render_template 'operations/index' }
    it 'has response status' do
      expect(response.status).to eq 200
    end
  end

  describe 'POST#create' do
    let(:operation) { FactoryBot.create(:operation) }
    let(:arg_a) { '1' }
    let(:arg_b) { '1' }
    let(:commit) { '+' }
    let(:request_params) do
      {
        arg_a: arg_a,
        arg_b: arg_b,
        commit: commit
      }
    end
    let(:service_params) { strong_params.permit(:arg_a, :arg_b, :commit) }

    subject(:response) { post :create, format: :js, params: request_params  }

    it 'calls Operations::CreateService' do
      expect(Operations::CreateService).to receive(:perform).with(service_params).and_return(operation)
      subject
    end

    it { is_expected.to render_template 'operations/create' }

    it 'has response status' do
      expect(response.status).to eq 200
    end

    it 'returns operation`s hash' do
      allow(Operations::CreateService).to receive(:perform).with(service_params).and_return(operation)
      subject
      expect(assigns(:result)).to eq operation.as_hash
    end

    context 'when params is invalid' do
      let(:arg_a) { nil }
      let(:arg_b) { nil }

      it 'renders error' do
        subject
        expect(assigns(:error)).to include message: 'error'
      end
    end
  end
end
