require 'csv'

#RideShare::AdditionalFunctionality.add_cost_and_duration


module RideShare

  class Trip

    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating, :cost, :duration

    def initialize(args)
      @trip_id = args[:trip_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]
      @cost = args[:cost]
      @duration = args[:duration]

      raise ArgumentError.new("Rating must be a number from 1 to 5.") if ((@rating.class != Integer) && (@rating.class != Float))
      raise Invalid_Rating_Error.new("Rating must be from 1 to 5.") if !(1 <= @rating.to_f && @rating.to_f <=5)
    end

    def self.all
      all_trips =[]
      CSV.foreach("support/trips_optionals.csv", {:headers => true}) do |line|
        all_trips << self.new( {trip_id:line[0].to_i, driver_id:line[1].to_i, rider_id:line[2].to_i, date:line[3], rating:line[4].to_i, cost:line[5].to_f, duration:line[6].to_f} )
      end
      return all_trips
    end

    def self.all_by(type, id)
      case type
      when 'driver'
        trips = all.select {|trip| trip.driver_id == id}
      when 'rider'
        trips = all.select {|trip| trip.rider_id == id}
      else puts "Doesn't recognize that type of user."
      end
      return trips
      #Note: Will return an empty array if type is 'driver' or 'rider' and requested id is not found. Will return nil if type is neither 'driver' nor 'rider'.
    end

    def driver
      #Driver is a class method of the Driver class.
      Driver.find(@driver_id)
    end

    def rider
      #Rider is a class method of the Rider class.
      Rider.find(@rider_id)
    end

  end
end
