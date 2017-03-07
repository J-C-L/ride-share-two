
module RideShare

  class Driver

    attr_reader :id, :name, :vin

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vin = args[:vin]
      raise ArgumentError.new("Invalid vin") if vin.length != 17
    end


    # def self.all
    #    all_drivers =[]
    #    CSV.open("support/drivers.csv").each do |line|
    #      all_drivers << self.new({id:line[0], name:line[1], vin:line[2]}
    #    end
    #    return all_drivers
    #
    #  end


# CSV.foreach("../support/trips.csv", {:headers => true}) do |row|




  end
end
