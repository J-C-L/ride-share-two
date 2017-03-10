require_relative '../specs/spec_helper'

describe "RideShare::Driver" do

  let(:new_driver_hash) { {id:42, name:'Granville Mertz', vin:'1B9TPKC24YPL290Y4'} }
  let(:new_driver) {RideShare::Driver.new(new_driver_hash)}


  describe "RideShare::Driver#initialize" do

    it "Creates a new instance of Driver class" do
      new_driver.must_be_instance_of RideShare::Driver
    end

    it "Takes a argument hash and assigns an id, name, and vin" do

      new_driver.must_respond_to :id
      new_driver.id.must_equal new_driver_hash[:id]

      new_driver.must_respond_to :name
      new_driver.name.must_equal new_driver_hash[:name]

      new_driver.must_respond_to :vin
      new_driver.vin.must_equal new_driver_hash[:vin]
    end

    it "Raises an Invalid_VIN_Error when created with an invalid vin (ie. vin of wrong length or no VIN is provided)." do
      bad_vin_hash = {vin:'1B9TPKC24YPL290Y4-9999'}
      no_vin = {id:999}
      proc {
        RideShare::Driver.new(bad_vin_hash)
      }.must_raise RideShare::Invalid_VIN_Error
      proc {
        RideShare::Driver.new(no_vin)
      }.must_raise RideShare::Invalid_VIN_Error
    end
  end


  describe "RideShare::Driver.all" do

    it "Returns an array of Driver instances" do
      RideShare::Driver.all.must_be_instance_of Array, "Not an array."
      RideShare::Driver.all.each do |driver|
        driver.must_be_instance_of   RideShare::Driver, "Not an instance of Driver class."
      end
    end

    it "Returns an array with the correct number of drivers" do
      number_of_drivers = CSV.read("support/drivers.csv").length - 1
      RideShare::Driver.all.length.must_equal number_of_drivers, "Wrong number of drivers"
    end

    it "gives correct values for the ID, NAME, and VIN of the last
    driver in the CSV file" do
    RideShare::Driver.all.last.id.must_equal 100, "ID of last driver is incorrect."
    RideShare::Driver.all.last.name.must_equal 'Minnie Dach', "NAME of last driver is incorrect."
    RideShare::Driver.all.last.vin.must_equal 'XF9Z0ST7X18WD41HT', "VIN of last driver is incorrect."
  end
end


describe "RideShare::Driver.find" do
  it "Returns a Driver" do
    RideShare::Driver.find(88).must_be_instance_of RideShare::Driver, "Does not return a driver"
  end

  it "Outputs a message and returns nil if driver id doesn't exist" do
    proc {
      RideShare::Driver.find(500)
    }.must_output(/.+/)

    RideShare::Driver.find(500).must_be_instance_of NilClass
  end

  it "Can find the last driver from the CSV" do
    #Using 'having the same id's' as a proxy for 'being the dame driver', since the 'last driver returned by 'all' after reading the CSV' and the appropriate driver returned by 'find' will not be the same internal object due to 'all' having been called separately for each.
    RideShare::Driver.find(100).id.must_equal RideShare::Driver.all.last.id, "Cannot find last account"
  end

  it "Returns nil if no driver with the given id is found." do
    RideShare::Driver.find(500).must_be_instance_of NilClass
  end
end

describe "RideShare::Driver.trips" do

  #This directly uses the RideShare::Trip.all_by(type, id) method, so we do not need to re-test the full functionality of that method. To test that the Driver.trips method is working appropriately, we can test one, nominal case and one edge case.
  it "Returns an array of Trip instances" do

    new_driver.trips.must_be_instance_of Array
    new_driver.trips.length.must_equal 7
    new_driver.trips.each do |trip|
      trip.must_be_instance_of RideShare::Trip
    end
  end

  it "returns an empty array if the driver has had no trips" do
    RideShare::Driver.all
    driver_100 = RideShare::Driver.find(100)
    #We know from manual inspection that this driver has no trips
    driver_100.trips.must_equal []
  end
end

describe "RideShare::Driver.ave_rating" do

  it "Returns a float." do
    new_driver.ave_rating.must_be_instance_of Float
  end

  it "Returns the average rating of a driver" do
    new_driver.ave_rating.must_equal 16/7.0
  end

  it "returns nil if the driver has had no trips or has received no ratings" do
    RideShare::Driver.all
    driver_100 = RideShare::Driver.find(100)
    #We know this driver has no trips
    driver_100.ave_rating.must_be_instance_of NilClass
  end
end


describe "RideShare::Driver.total_revenue" do
  it "Returns an float" do
    new_driver.total_revenue.must_be_instance_of Float
  end

  it "Returns the correct revenue for the driver's trips" do
    trips = CSV.read('support/trips_optionals.csv')
    trips_by_driver42 = trips.select {|trip| trip[1].to_i == 42}
    driver_42_revenue =(trips_by_driver42.map {|trip| trip[-2].to_f}.reduce(:+) - 1.65) *0.80

    new_driver.total_revenue.must_equal driver_42_revenue
  end
  #Didn't test edge cases because of time constraints.
end

end
