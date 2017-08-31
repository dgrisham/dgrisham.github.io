=begin
    Demo: Overloaded methods/operators

    This class represents a bottle of soda. We can
    - initialize
    - combine the contents of this and another bottle, return a new one
    - add the contents of another bottle to this one
    - split! the contents among some number of people/bottles. Return
    a new bottle containing the split! amount.
    - add some number of ounces to it
    - display it
=end

class Bottle
    # metaprogramming, provides read/write, read only or write only
    # access (not shown)
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

    # modify the contents of this bottle - notice the !
    def add!(other)
        @ounces += other.ounces
        other.ounces = 0
    end

    # split! the contents - should this have ! in the name?
    def split!(scalar)
        # local variable
        newOunces = @ounces / scalar
        @ounces -= newOunces
        Bottle.new(@label, newOunces)
    end

    # overloaded operator
    def +(amount)
        Bottle.new(@label, @ounces + amount)
    end

    def to_s
        # with an accessor, don't need @ - why?
        "(#{label}, #{ounces})"
    end
end


b = Bottle.new("Tab", 16)
# show accessors
puts b.label
b.ounces = 20
# show to_s
puts "b is #{b}"

puts "\nresult of b2 = b.split! 4"
b2 = b.split! 4
puts "b is #{b}"
puts "b2 is #{b2}"

puts "\nresult of b3 = b.add(b2)"
b3 = b.add(b2)
puts "b3 is #{b3}"
puts "b2 is #{b2}"

puts "\nresult of b.add!(b2)"
b.add!(b2)
puts "b is #{b}"
puts "b2 is #{b2}"

puts "\nresult of b4 = b3 + 10"
b4 = b3 + 10
puts "b4 is #{b4}"

puts "\nresult of b4 = b4 + 10"
b5 = b4.+ 10
puts "b5 is #{b5}"
