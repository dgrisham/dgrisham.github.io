=begin
	Demo: Overloading [] and each
	Corresponds to: RubyClasses.pptx
=end

class Bottle
	attr_accessor :ounces
	attr_reader :label
	
	def initialize(label, ounces)
		@label = label
		@ounces = ounces
	end
	
	# will return each field in order
	def each
		yield @label
		yield @ounces
	end
	
	def [](index)
		case index
			when 0, -2 then @label
			when 1, -1 then @ounces
			when :label, "label" then @label
			when :ounces, "ounces" then @ounces
		end
	end
	
end

b = Bottle.new("Tab", 16)
puts "Using each"
b.each {|x| puts x }
puts "\n Access by [ix] with overloaded []"
puts b[0]
puts b[-2]
puts b[1]
puts b[-1]
puts "\n Access by [field name] with overloaded []"
puts b["label"]
puts b[:label]
puts b["ounces"]
puts b[:ounces]
