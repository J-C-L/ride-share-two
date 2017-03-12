require 'csv'

module RideShare

  class Loadables


    def self.all(filepath, classtype, args_keys)
      # filepath = "support/drivers.csv"
      # classtype = Driver
      #  args_keys = [:id, :name, :vin]
       args = {}

      all_instances =[]
      CSV.foreach(filepath, {:headers => true}) do |line|

         args_keys.each do |key|
           args[key] = line[args_keys.index(key)]
         end

        all_instances << classtype.new(args)
      end
      return all_instances
    end

  end
end




module RideShare

  class Driver < Loadables

    attr_reader :id, :name, :vin

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @vin = args[:vin]
    end

    def self.all



      # all_drivers =[]
      # CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
      #   all_drivers << self.new({id:line[0].to_i, name:line[1], vin:line[2]})
      # end
      # return all_drivers
    end
    #
    # def self.find(driver_id)
    #   found_driver = all.find {|driver| driver.id == driver_id}
    #   puts "That driver doesn't exist." if found_driver == nil
    #   #Note: If the requested driver id isn't found, method will return nil, and not raise an error.
    #   return found_driver
    # end
  end
end

#
# puts RideShare::Driver.all.length
# puts driver_1= RideShare::Driver.new({id:900, name:"Janice"})


#RideShare::Loadables.all.each {|driver| puts driver.name}

puts RideShare::Loadables.all("support/drivers.csv", RideShare::Driver, [:id, :name, :vin])[6].name
