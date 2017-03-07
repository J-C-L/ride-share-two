
require 'csv'

module RideShare

  class Driver

    attr_reader :id, :name, :vin

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vin = args[:vin]
      raise ArgumentError.new("Invalid vin") if vin.length != 17
    end


    def self.all
       all_drivers =[]
       CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
         all_drivers << self.new({id:line[0], name:line[1], vin:line[2]})
        #  puts "Driver id is #{line[0]} and vin is #{line[2]}. VIN HAS LENGTH: #{line[2].length}"
        #  puts "INVALID VIN" if line[2].length != 17
       end
       return all_drivers
     end

  end
end

puts RideShare::Driver.all[0].name
