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
        }.must_raise ArgumentError

        proc {
          RideShare::Trip.new({rating:6})
        }.must_raise ArgumentError

        proc {
          RideShare::Trip.new({rating:'a'})
        }.must_raise ArgumentError

      end
  end
end
