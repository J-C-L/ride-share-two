require_relative '../specs/spec_helper'

describe "RideShare::Trip" do

  let(:new_trip_hash) { {trip_id:42, driver_id:69, rider_id:267, date:'2017-01-14', rating:2} }

  let(:new_trip) {RideShare::Trip.new(new_trip_hash)}


  describe "RideShare::Trip#initialize" do

    it "Creates a new instance of Trip class" do
      new_trip = RideShare::Trip.new(new_trip_hash)
      new_trip.must_be_instance_of RideShare::Trip
    end

    it "Takes a argument hash and assigns a trip_id, driver_id, rider_id, date, and rating" do
      new_trip.must_respond_to :trip_id
      new_trip.trip_id.must_equal new_trip_hash[:trip_id]

      new_trip.must_respond_to :driver_id
      new_trip.driver_id.must_equal new_trip_hash[:driver_id]

      new_trip.must_respond_to :rider_id
      new_trip.rider_id.must_equal new_trip_hash[:rider_id]

      new_trip.must_respond_to :date
      new_trip.date.must_equal new_trip_hash[:date]

      new_trip.must_respond_to :rating
      new_trip.rating.must_equal new_trip_hash[:rating]
    end

    it "Raises an Invalid_Rating_Error when created with an out of bounds rating" do
      proc {
        RideShare::Trip.new({rating:0})
      }.must_raise RideShare::Invalid_Rating_Error
      proc {
        RideShare::Trip.new({rating:6})
      }.must_raise RideShare::Invalid_Rating_Error
    end

    it "Raises an ArgumentError when created with a non-numeric rating" do
      proc {
        RideShare::Trip.new({rating: 'a'})
      }.must_raise ArgumentError
    end

    it "Accepts a float or integer for rating, including 5 and 1." do
      RideShare::Trip.new({rating: 5})
      RideShare::Trip.new({rating: 1})
      RideShare::Trip.new({rating: 2.2})
    end
  end

  describe "RideShare::Trip.all" do

    it "Returns an array of Trip instances" do
      RideShare::Trip.all.must_be_instance_of Array, "Not an array."
      RideShare::Trip.all.each do |trip|
        trip.must_be_instance_of  RideShare::Trip, "Not an instance of Trip class."
      end
    end

    it "Returns an array with the correct number of trips" do
      number_of_trips = CSV.read("support/trips.csv").length - 1
      RideShare::Trip.all.length.must_equal number_of_trips, "Wrong number of trips"
    end

    it "gives correct values for the trip_id, driver_id, rider_id, date, and rating of the last trip in the CSV file" do
      last_trip_hash ={trip_id:600, driver_id:61, rider_id:168, date:'2016-04-25', rating:3}
      RideShare::Trip.all.last.trip_id.must_equal last_trip_hash[:trip_id], "Trip ID of last trip is incorrect."
      RideShare::Trip.all.last.driver_id.must_equal last_trip_hash[:driver_id], "Driver ID of last trip is incorrect."
      RideShare::Trip.all.last.rider_id.must_equal last_trip_hash[:rider_id], "Rider ID of last trip is incorrect."
      RideShare::Trip.all.last.date.must_equal last_trip_hash[:date], "Date of last trip is incorrect."
      RideShare::Trip.all.last.rating.must_equal last_trip_hash[:rating], "Rating of last trip is incorrect."
    end
  end


  describe "RideShare::Trip.all_by(type, id)" do

    it "Returns an array of Trip instances when type is 'driver' or rider" do
      RideShare::Trip.all_by('driver', 42).must_be_instance_of Array, "Not an array."
      RideShare::Trip.all_by('driver', 42).each do |trip|
        trip.must_be_instance_of  RideShare::Trip, "Not an instance of Trip class."
      end
      RideShare::Trip.all_by('rider', 54).must_be_instance_of Array, "Not an array."
      RideShare::Trip.all_by('rider', 54).each do |trip|
        trip.must_be_instance_of  RideShare::Trip, "Not an instance of Trip class."
      end
    end

    it "Outputs a 'Doesn't recognize that type of user' message when type is neither 'driver' nor 'rider', and returns nil in that case" do
      proc {
        RideShare::Trip.all_by('dancer', 54)
      }.must_output(/.+/)

      RideShare::Trip.all_by('dancer', 54).must_be_instance_of NilClass
    end


    it "Returns trips with the desired driver id" do
      RideShare::Trip.all_by('driver', 42).each do |trip|
        trip.driver_id.must_equal 42
      end
    end

    it "Returns an array whose length is the number of trips for a particular driver_id from the CSV" do
      rides_by_driver_42 = CSV.read("support/trips.csv").find_all {|line| line[1] == '42'}
      RideShare::Trip.all_by('driver', 42).length.must_equal rides_by_driver_42.length
    end

    it "Returns empty array if no trips are found with the requested driver id."do
    RideShare::Trip.all_by('driver', 500).must_equal []
    RideShare::Trip.all_by('driver', 'Dan').must_equal []
  end

  it "Returns trips with the desired rider id" do
    RideShare::Trip.all_by('rider', 54).each do |trip|
      trip.rider_id.must_equal 54
    end
  end

  it "Returns an array whose length is the number of trips for a particular rider id from the CSV" do
    rides_by_rider_54 = CSV.read("support/trips.csv").find_all {|line| line[2] == '54'}
    RideShare::Trip.all_by('rider', 54).length.must_equal rides_by_rider_54.length
  end

  it "Returns empty array if no trips are found with the requested rider id." do
  RideShare::Trip.all_by('rider', 500).must_equal []
  RideShare::Trip.all_by('rider','Dan').must_equal []
  end
end


end








#   describe "RideShare::Trip.all_by_driver" do
#
#     it "Returns an array of Trip instances" do
#       RideShare::Trip.all_by_driver(42).must_be_instance_of Array, "Not an array."
#       RideShare::Trip.all_by_driver(42).each do |trip|
#         trip.must_be_instance_of  RideShare::Trip, "Not an instance of Trip class."
#       end
#     end
#
#     it "Returns trips with the desired driver id" do
#       RideShare::Trip.all_by_driver(42).each do |trip|
#         trip.driver_id.must_equal 42
#       end
#     end
#
#     it "Returns an array whose length is the number of trips for a particular driver_id from the CSV" do
#       rides_by_driver_42 = CSV.read("support/trips.csv").find_all {|line| line[1] == '42'}
#       RideShare::Trip.all_by_driver(42).length.must_equal rides_by_driver_42.length
#     end
#
#     it "Returns empty array if no trips are found with the requested driver id."do
#     RideShare::Trip.all_by_driver(500).must_equal []
#     RideShare::Trip.all_by_driver('Dan').must_equal []
#     end
# end
#
#
# describe "RideShare::Trip.all_by_rider" do
#
#   it "Returns an array of Trip instances" do
#     RideShare::Trip.all_by_rider(54).must_be_instance_of Array, "Not an array."
#     RideShare::Trip.all_by_rider(54).each do |trip|
#       trip.must_be_instance_of  RideShare::Trip, "Not an instance of Trip class."
#     end
#   end
#
#   it "Returns trips with the desired rider 54" do
#     RideShare::Trip.all_by_rider(54).each do |trip|
#       trip.rider_id.must_equal 54
#     end
#   end
#
#   it "Returns an array whose length is the number of trips for a particular rider_54 from the CSV" do
#     rides_by_rider_54 = CSV.read("support/trips.csv").find_all {|line| line[2] == '54'}
#     RideShare::Trip.all_by_rider(54).length.must_equal rides_by_rider_54.length
#   end
#
#   it "Returns empty array if no trips are found with the requested rider." do
#   RideShare::Trip.all_by_rider(540).must_equal []
#   RideShare::Trip.all_by_rider('Dan').must_equal []
#   end
# end
