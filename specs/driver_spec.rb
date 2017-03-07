require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'

#Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new



describe "RideShare::Driver" do

  before do
    @new_driver_hash = {id:'42', name:'Granville Mertz', vin:'1B9TPKC24YPL290Y4'}
    @new_driver = RideShare::Driver.new(@new_driver_hash)
  end

  describe "RideShare::Driver#initialize" do

    it "Creates a new instance of Driver class" do
      # new_driver_hash = {id:'42', name:'Granville Mertz', vin:'1B9TPKC24YPL290Y4'}
      # new_driver = RideShare::Driver.new(new_driver_hash)
      @new_driver.must_be_instance_of RideShare::Driver
    end

    it "Takes a argument hash and assigns an id, name, and vin" do
      # new_driver_hash = {id:'42', name:'Granville Mertz', vin:'1B9TPKC24YPL290Y4'}
      # new_driver = RideShare::Driver.new(new_driver_hash)

      @new_driver.must_respond_to :id
      @new_driver.id.must_equal @new_driver_hash[:id]

      @new_driver.must_respond_to :name
      @new_driver.name.must_equal @new_driver_hash[:name]

      @new_driver.must_respond_to :vin
      @new_driver.vin.must_equal @new_driver_hash[:vin]
    end
    #
    # it "Raises an ArgumentError when created with an invalid vin (ie. vin of wrong length) " do
    #   bad_vin_hash = {vin:'1B9TPKC24YPL290Y4-9999'}
    #
    #   proc {
    #     new_driver = RideShare::Driver.new(bad_vin_hash)
    #   }.must_raise ArgumentError
    # end

  end
end
