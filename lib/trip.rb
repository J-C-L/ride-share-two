require 'csv'
require_relative 'exception_classes.rb'

module RideShare

  class Trip

    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(args)
      @trip_id = args[:trip_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]

      raise ArgumentError.new("Rating must be a number from 1 to 5.") if @rating.class != (Integer||Float)
      raise Invalid_Rating_Error.new("Rating must be from 1 to 5.") if !(1 <= @rating.to_f && @rating.to_f <=5)
    end

    def self.all
      all_trips =[]
      CSV.foreach("support/trips.csv", {:headers => true}) do |line|
        all_trips << self.new( {trip_id:line[0].to_i, driver_id:line[1].to_i, rider_id:line[2].to_i, date:line[3], rating:line[4].to_i} )
      end
      return all_trips
    end

    def self.all_by_driver(driver_id)

      all.select do  |trip|
        #Note: Will return nil if driver id is not found
        trip.driver_id == driver_id
      end
    end






  end
end
