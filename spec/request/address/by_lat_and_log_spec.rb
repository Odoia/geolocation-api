require 'rails_helper'

describe '::Api::V1::AddressController', type: :request do

  let(:body) { JSON.parse(response.body) }
  let(:address_geolocation) { { address: { geolocation: [-9.6312309, -35.7414643] } } }
  let(:invalid_param) { { address: {} } }

  context 'When need search a address' do
    context 'When pass a invalid params' do
      it 'shoud be return a status 400' do
        get '/api/v1/address', params: invalid_param

        expect(response.status).to be 400
        expect(body['data']).to eq 'Bad Request'
      end
    end

    context 'When pass a valid lat and log' do

      it 'shoud be return a status 200 and a correctly data' do
        get '/api/v1/address', params: address_geolocation

        expect(response.status).to be 200
        expect(body['data']['cep']).to eq '57057-540'
        expect(body['data']['neighborhood']).to eq 'Vila Alto do Ceu'
      end
    end
  end
end
