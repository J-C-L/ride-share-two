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
  found_drivers = all.select {|driver| driver.id == driver_id}
  raise ArgumentError.new("That driver id doesn't exist!")  if found_drivers[0]==nil
  #The following is not testable without ammending the CSV, given our setup, so I am not including the error raising
  # raise ArgumentError.new("Uh-oh. There are multiple drivers with that ID!")  if found_drivers[0]!= 1
  return found_drivers[0]
end




  end
end

#puts RideShare::Driver.all[5].name
#puts CSV.read("support/drivers.csv").length
