module Presenters
  class Address
    attr_reader :cep, :region, :state, :city, :neighborhood, :lat, :lon, :full_address

    def initialize(attrs)
      @cep          = address(attrs)['postcode']
      @region       = address(attrs)['region']
      @state        = address(attrs)['state']
      @city         = address(attrs)['city']
      @neighborhood = address(attrs)['suburb']
      @lat          = data(attrs)['lat']
      @lon          = data(attrs)['lon']
      @full_address = data(attrs)['display_name']
    end

    private

    def address(attrs)
      attrs.first.data['address']
    end

    def data(attrs)
      attrs.first.data
    end
  end
end
