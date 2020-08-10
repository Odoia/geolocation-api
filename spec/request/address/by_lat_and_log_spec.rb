require 'rails_helper'

describe '::Api::V1::AddressController', type: :request do

  let(:body) { JSON.parse(response.body) }
  let(:address) { { address: { geolocation: [-9.6312309, -35.7414643] } } }

  context 'When need search a address' do
    context 'When pass a valid lat and log' do

      it 'shoud be return a a status 200 and a correctly data' do
        get '/api/v1/address', params: address

        expect(response.status).to be 200
        expect(body['data']['cep']).to eq '57057-540'
      end
    end
  end
end
