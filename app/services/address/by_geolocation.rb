module Services
  module Address
    class ByGeolocation

      def initialize(geolocation:)
        @latitude  = geolocation.first
        @longitude = geolocation.second
      end

      def call
        full_address_by_geolocation
      end

      private

      attr_reader :latitude, :longitude

      def full_address_by_geolocation
        result = Geocoder.search([latitude, longitude])
        address_presenter(address: result)
      end

      def address_presenter(address:)
        ::Presenters::Address.new(address)
      end
    end
  end
end
