require 'csv'

module RideShare

  class Rider

    attr_reader :id, :name, :phone

    def initialize(args)
      @id = args[:id]
      @name = args[:name]
      @phone = args[:phone]
    end

    def self.all
      all_riders =[]
      CSV.foreach("support/riders.csv", {:headers => true}) do |line|
        all_riders << self.new({id:line[0].to_i, name:line[1], phone:line[2]})
      end
      return all_riders
    end

    def self.find(rider_id)
      found_rider = all.find {|rider| rider.id == rider_id}
      # raise ID_Not_Found_Error.new("That rider id doesn't exist!") if found_rider==nil
      #Note: If the rider id isn't found, method will return nil.
      return found_rider
    end


    def trips
      Trip.all_by('rider', @id)
    end
    
  end
end
