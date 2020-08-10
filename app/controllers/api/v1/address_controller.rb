module Api
  module V1
    class AddressController < ApplicationController
      before_action :address_params, only: %i[show]


      def show
        result = geolocation_service
        render status: 200, json: { data: result, status: 200 }
      end


      private

      def address_params
        params.require(:address)
      end

      def geolocation_service
        ::Services::Address::ByGeolocation.new(geolocation: address_params['geolocation'] ).call
      end
    end
  end
end
