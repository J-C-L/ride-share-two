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

    it "Raises an ArgumentError when created with an invalid rating" do
      proc {
        RideShare::Trip.new({rating:0})
      }.must_raise RideShare::Invalid_Rating_Error
      proc {
        RideShare::Trip.new({rating:6})
      }.must_raise RideShare::Invalid_Rating_Error
      proc {
        RideShare::Trip.new({rating:'a'})
      }.must_raise RideShare::Invalid_Rating_Error
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


  describe "RideShare::Trip.all_by_driver" do

    it "Returns an array of Trip instances" do
      driver_id = 42
      RideShare::Trip.all_by_driver(driver_id).must_be_instance_of Array, "Not an array."
      RideShare::Trip.all_by_driver(driver_id).each do |trip|
        trip.must_be_instance_of  RideShare::Trip, "Not an instance of Trip class."
      end
    end

    it "Returns  trips with the desired driver id" do
    end

    it "Returns ALL trips with the desired driver id" do
    end


  end


  # find all trip instances for a given rider ID
end
