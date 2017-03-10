require 'simplecov'
SimpleCov.start

require 'pry'

require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/pride'

reporter_options = {color: true}
Minitest::Reporters.use! [Minitest::Reporters::DefaultReporter.new(reporter_options)]

#Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

require_relative '../lib/driver'
require_relative '../lib/rider'
require_relative '../lib/trip'
require_relative '../lib/exception_classes.rb'
require_relative '../lib/additional_functionality.rb'
