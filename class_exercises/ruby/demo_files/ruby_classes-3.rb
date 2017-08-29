=begin
	Demo: Duck Typing
	Corresponds to: RubyClasses.pptx
=end

class Bottle
	attr_accessor :ounces
	attr_reader :label
	
	def initialize(label, ounces)
		@label = label
		@ounces = ounces
	end
	
	# simple method, returns a new bottle
	def add(other) 
		Bottle.new(@label, @ounces+other.ounces)
	end

	def to_s
		"(#@label, #@ounces)"
	end
	
end

# Can also has ounces
class Can
	attr_accessor :ounces
	def initialize(label, ounces)
		@label = label
		@ounces = ounces
	end
	def to_s
		"(#@label, #@ounces)"
	end
end

# Cat does not have ounces
class Cat
end

b = Bottle.new("Tab", 16)

# duck typing
c = Can.new("Coke", 12)
b2 = b.add(c)
puts "Result of b2 = b.add(c)"
puts "b2 is #{b2}"
cat = Cat.new
# The following line generates an undefined method error
# b3 = b.add(cat)










