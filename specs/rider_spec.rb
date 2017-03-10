require_relative '../specs/spec_helper'

describe "RideShare::Rider" do

  let(:new_rider_hash) { {id:146, name:'Kirk Hand', phone: '(175) 727-5781'} }
  let(:new_rider) {RideShare::Rider.new(new_rider_hash)}

  describe "RideShare::Rider#initialize" do

    it "Creates a new instance of Rider class" do
      new_rider.must_be_instance_of RideShare::Rider
    end

    it "Takes a argument hash and assigns an id, name, and phone number" do
      new_rider.must_respond_to :id
      new_rider.id.must_equal new_rider_hash[:id]

      new_rider.must_respond_to :name
      new_rider.name.must_equal new_rider_hash[:name]

      new_rider.must_respond_to :phone
      new_rider.phone.must_equal new_rider_hash[:phone]
    end
  end


  describe "RideShare::Rider.all" do

    it "Returns an array of Rider instances" do
      RideShare::Rider.all.must_be_instance_of Array, "Not an array."
      RideShare::Rider.all.each do |rider|
        rider.must_be_instance_of   RideShare::Rider, "Not an instance of Rider class."
      end
    end

    it "Returns an array with the correct number of riders" do
      number_of_riders = CSV.read("support/riders.csv").length - 1
      RideShare::Rider.all.length.must_equal number_of_riders, "Wrong number of riders"
    end

    it "gives correct values for the ID, NAME, and PHONE NUMBER of the last
    rider in the CSV file" do
    RideShare::Rider.all.last.id.must_equal 300, "ID of last rider is incorrect."
    RideShare::Rider.all.last.name.must_equal 'Miss Isom Gleason', "NAME of last rider is incorrect."
    RideShare::Rider.all.last.phone.must_equal '791-114-8423 x70188', "Phone number of last rider is incorrect."
  end
end


describe "RideShare::Rider.find" do
  it "Returns a Rider" do
    RideShare::Rider.find(88).must_be_instance_of RideShare::Rider, "Does not return a rider"
  end


  it "Can find the last rider from the CSV" do
    #Using 'having the same id's' as a proxy for 'being the dame rider', since the 'last rider returned by 'all' after reading the CSV' and the appropriate rider returned by 'find' will not be the same internal object due to 'all' having been called separately for each.
    RideShare::Rider.find(300).id.must_equal RideShare::Rider.all.last.id, "Cannot find last account"
  end

  it "Outputs a message and returns nil if no rider with the given id is found." do
    proc {
      RideShare::Rider.find(500)
    }.must_output(/.+/)
    RideShare::Rider.find(500).must_be_instance_of NilClass
  end
end

describe "RideShare::Rider.trips" do

  #This directly uses the RideShare::Trip.all_by(type, id) method, so we do not need to re-test the full functionality of that method. To test that the Rider.trips method is working appropriately, we can test one, nominal case and one edge case.
  it "Returns an array of Trip instances" do
    new_rider.trips.must_be_instance_of Array
    new_rider.trips.length.must_equal 4
    new_rider.trips.each do |trip|
      trip.must_be_instance_of RideShare::Trip
    end
  end


  it "returns an empty array if the driver has had no trips" do
    RideShare::Rider.all
    rider_300 = RideShare::Rider.find(300)
    #We know from manual inspection that this driver has no trips
    rider_300.trips.must_equal []
  end
end


describe "RideShare::Driver.drivers_used" do
  it "Returns an array" do
    new_rider.drivers_used.must_be_instance_of Array
  end

  it "Returns an array of driver instances" do
    new_rider.drivers_used.each do |driver|
      driver.must_be_instance_of RideShare::Driver
    end
  end

  it "Returns an array of ALL drivers used for that rider" do
    new_rider.drivers_used.length.must_equal 4
    new_rider.drivers_used.map {|driver| driver.id}.must_equal [67,17,77, 1]
  end

  it "Returns an empty array if the rider has taken no rides, and thus has had no drivers." do
    rider_300 = RideShare::Rider.find(300)
    rider_300.drivers_used.must_equal []
  end
end

end
