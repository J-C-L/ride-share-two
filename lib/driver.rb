require 'csv'

module RideShare

  class Driver

    attr_reader :id, :name, :vin

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vin = args[:vin]
      #Raising an error here to disallow drivers without valid cars
      raise Invalid_VIN_Error.new("Invalid vin") if vin.length != 17
    end

    def self.all
      all_drivers =[]
      CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
        all_drivers << self.new({id:line[0].to_i, name:line[1], vin:line[2]})
      end
      return all_drivers
    end

    def self.find(driver_id)
      found_driver = all.find {|driver| driver.id == driver_id}
      # raise ID_Not_Found_Error.new("That driver id doesn't exist!") if found_driver==nil
      #Note: If the driver id isn't found, method will return nil.
      return found_driver
    end


    def trips
      Trip.all_by('driver', @id)
    end

    def ave_rating
      trips.map {|trip| trip.rating}.reduce(:+)/trips.length.to_f
    end


  end
end

#puts RideShare::Driver.all[5].name
#puts CSV.read("support/drivers.csv").length
# puts RideShare::Driver.find(100).name
# puts RideShare::Driver.all.last.name
