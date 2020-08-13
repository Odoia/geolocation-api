module Api
  module V1
    class AddressController < ApplicationController
      before_action :address_params, only: %i[show] 

      def show
        result = address_params['cep'].blank? ? geolocation_service : cep_service

        if result.blank?
          render_error
        else
          render status: 200, json: { data: result, status: 200 }
        end
      end

      private

      def address_params
        return render_error if params['address'].blank?

        params.require(:address)
      end

      def geolocation_service
        ::Services::Address::ByGeolocation.new(geolocation: address_params['geolocation']).call
      end

      def cep_service
        ::Services::Address::ByCep.new(cep: address_params['cep']).call
      end

      def render_error
        render nothing: true, status: 400, json: { data: 'Bad Request', status: 400 }
      end
    end
  end
end
