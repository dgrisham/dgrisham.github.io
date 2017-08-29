=begin
	Demo: Object equality
	Corresponds to: RubyClasses.pptx
=end

class Bottle
	attr_accessor :ounces
	attr_reader :label
	
	def initialize(label, ounces)
		@label = label
		@ounces = ounces
	end
		
	def ==(other)
		return false if ! other.instance_of? Bottle
		return @ounces == other.ounces && @label == other.label
	end
	
	alias eql? ==

end

# Can also has ounces
class Can
	attr_accessor :ounces
	def initialize(label, ounces)
		@label = label
		@ounces = ounces
	end
end

b = Bottle.new("Tab", 16)
b2 = Bottle.new("Tab", 16)
b3 = Bottle.new("Tab", 12)
b4 = Bottle.new("Coke", 16)
puts "b.equal?(b2) #{b.equal?(b2)}"
puts "b == b2 #{b == b2}"
puts "b == b3 #{b == b3}"
puts "b == b4 #{b == b4}"
puts "b.eql?(b2) #{b.eql?(b2)}"
puts "b.eql?(b3) #{b.eql?(b3)}"


c = Can.new("Tab", 16)
puts "b == c #{b == c}"

puts "\nNumeric equality"
x = 1.0
y = 1
puts "x == y #{x == y}"
puts "x.eql? y #{x.eql? y}"

puts "\n=== used mostly in case statements"
puts "(1..10) === 20 #{(1..10) === 20 }" 
puts "(1..10) === 5 #{(1..10) === 5 }" 




