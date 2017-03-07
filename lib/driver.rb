
module RideShare

  class Driver

    attr_reader :id, :name, :vin

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vin = args[:vin]
      raise ArgumentError.new("Invalid vin") if vin.length != 17
    end
  end
end
