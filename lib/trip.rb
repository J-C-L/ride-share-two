require 'csv'

module RideShare

  class Trip

    attr_reader :trip_id, :driver_id, :rider_id, :date, :rating

    def initialize(args)
      @trip_id = args[:trip_id]
      @driver_id = args[:driver_id]
      @rider_id = args[:rider_id]
      @date = args[:date]
      @rating = args[:rating]
      raise ArgumentError.new("Rating must be from 1 to 5.") if !(1 <= @rating.to_f && @rating.to_f <=5)
    end

    # def self.all
    #   all_drivers =[]
    #   CSV.foreach("support/drivers.csv", {:headers => true}) do |line|
    #     all_drivers << self.new({id:line[0].to_i, name:line[1], vin:line[2]})
    #   end
    #   return all_drivers
    # end
  end
end
