require 'simplecov'
SimpleCov.start

require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/skip_dsl'
require_relative '../lib/driver'

#Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new


describe "RideShare::Driver" do

  describe "initialize" do
  
    it "Creates a new instance of Driver class" do
      new_driver = RideShare::Driver.new
      new_driver.must_be_instance_of RideShare::Driver
    end

  end
end
