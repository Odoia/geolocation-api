require 'rails_helper'

describe '::Api::V1::AddressController', type: :request do

  let(:body) { JSON.parse(response.body) }
  let(:address_cep_with) { { address: { cep: '57035-330' } } }
  let(:address_cep_without) { { address: { cep: '57035330' } } }
  let(:invalid_param) { { address: {} } }

  context 'When need search a address' do
    context 'When pass a invalid params' do
      it 'shoud be return a status 400' do
        get '/api/v1/address', params: invalid_param

        expect(response.status).to be 400
        expect(body['data']).to eq 'Bad Request'
      end
    end

    context 'When pass a valid cep' do
      context 'When pass a cep with - ' do

        it 'shoud be return a a status 200 and a correctly data' do
          get '/api/v1/address', params: address_cep_with

          expect(response.status).to be 200
          expect(body['data']['cep']).to eq '57035-330'
          expect(body['data']['neighborhood']).to eq 'Ponta Verde'
        end
      end

      context 'When pass a cep without - ' do

        it 'shoud be return a a status 200 and a correctly data' do
          get '/api/v1/address', params: address_cep_without

          expect(response.status).to be 200
          expect(body['data']['cep']).to eq '57035-330'
          expect(body['data']['neighborhood']).to eq 'Ponta Verde'
        end
      end
    end
  end
end
