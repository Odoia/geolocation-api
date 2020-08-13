module Services
  module Address
    class ByCep

      def initialize(cep:)
        @cep = cep.last(4).first == '-' ? cep : format_cep(cep)
      end

      def call
        full_address_by_cep
      end

      private

      attr_reader :cep

      def full_address_by_cep
        result = Geocoder.search(cep)
        address_presenter(address: result)
      end

      def address_presenter(address:)
        ::Presenters::Address.new(address)
      end

      def format_cep(cep)
        cep.insert(5, '-')
      end
    end
  end
end
