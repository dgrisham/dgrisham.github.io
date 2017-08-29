=begin
	Demo: Unit test syntax
	Corresponds to: RubyUnitTest.pptx
=end

class Converter
	# class variable
	@@FEET_TO_METERS = 0.3048

	def feetToMeters (feet)
		return feet * @@FEET_TO_METERS
	end
end

require 'minitest/autorun'
# your class must extend MiniTest::Test
class ConverterTest < MiniTest::Test
	# need an epsilon to do floating point compare
	@@EPSILON = 0.0001
	
	# method names must start with test to be automatically executed
	def test_feetToMeters
		converter = Converter.new
		assert_in_delta(3.048, converter.feetToMeters(10), @@EPSILON)
		assert_in_delta(0.3048, converter.feetToMeters(1), @@EPSILON)
		assert_in_delta(0.4572, converter.feetToMeters(1.5), @@EPSILON)
	end
end

