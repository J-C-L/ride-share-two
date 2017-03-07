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
        all_drivers << self.new({id:line[0].to_i, name:line[1], vin:line[2]})
      end
      return all_drivers
    end


    def self.find(driver_id)
      driver = all.find {|driver| driver.id == driver_id}
      raise ArgumentError.new("That driver id doesn't exist!") if driver==nil
      return driver
    end


    # def trips
    #   RideShare::Trip.find_all_by_driver(@id)
    # end

    # def ave_rating
    #   # ratings = trips.map {|trip| trip.rating}
    #   # ratings.reduce(:+)/ratings.length
    #   #OR
    #   #trips.map {|trip| trip.rating}.reduce(:+)/trips.length
    # end
  end
end

#puts RideShare::Driver.all[5].name
#puts CSV.read("support/drivers.csv").length
# puts RideShare::Driver.find(100).name
# puts RideShare::Driver.all.last.name
