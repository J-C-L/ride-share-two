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

    it "Raises an Invalid_VIN_Error when created with an invalid vin (ie. vin of wrong length)" do
      bad_vin_hash = {vin:'1B9TPKC24YPL290Y4-9999'}
      proc {
        RideShare::Driver.new(bad_vin_hash)
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

  # it "Raises ArgumentError if driver id doesn't exist" do
  #   proc {
  #     RideShare::Driver.find(500)
  #   }.must_raise RideShare::ID_Not_Found_Error
  # end

  it "Can find the last driver from the CSV" do
    #Checking that the id's of the returned and last drivers are the same, since they will not be the same internal object due to 'all' having been called separated for each.
    RideShare::Driver.find(100).id.must_equal RideShare::Driver.all.last.id, "Cannot find last account"
  end
end

describe "RideShare::Driver.trips" do

  #This directly uses the RideShare::Trip.all_by(type, id) method, so we do not need to re-test the full functionality of that method. To test that the Driver.trips method is working appropriately, we can test one, nominal case.
  it "Returns an array of Trip instances" do
    new_driver.trips.length.must_equal 7
    new_driver.trips.must_be_instance_of Array
    new_driver.trips[0].must_be_instance_of RideShare::Trip
  end
end

end
