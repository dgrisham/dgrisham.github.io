=begin
    Demo: Comparisons and Hash code
=end

class Bottle
    include Comparable

    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    def hash
        #based on Effective Java by Bloch
        code = 17
        code = 37 * code + @label.hash
        code = 37 * code + @ounces.hash
        code
    end

    def <=>(other)
        return nil unless other.instance_of? Bottle
        @ounces <=> other.ounces
    end
end

b = Bottle.new("Tab", 16)
b2 = Bottle.new("Tab", 12)
b3 = Bottle.new("Coke", 16)
b4 = Bottle.new("Tab", 16)

puts "b == b2 #{b == b2}"
puts "b < b2 #{b < b2}"
puts "b > b2 #{b > b2}"
puts "b == b3 #{b == b3}"
puts "b == b4 #{b == b4}"
