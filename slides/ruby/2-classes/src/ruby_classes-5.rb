=begin
    Demo: Type-safe methods
=end

class Bottle
    attr_accessor :ounces
    attr_reader :label

    def initialize(label, ounces)
        @label = label
        @ounces = ounces
    end

    # require the parameter to be a Bottle
    def add(other)
        raise TypeError, "Bottle argument expected " unless other.is_a? Bottle
        Bottle.new(@label, @ounces+other.ounces)
    end

    # allow any parameter with ounces
    def add2(other)
        raise TypeError, "Bottle argument expected " unless other.respond_to? :ounces
        Bottle.new(@label, @ounces+other.ounces)
    end

    # another option that requires ounces
    def add3(other)
        Bottle.new(@label, @ounces+other.ounces)
        # like "catch" for method not defined error
        rescue
            raise TypeError, "Cannot add with an argument that doesn't have ounces"
    end

    def to_s
        "(#@label, #@ounces)"
    end
end

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

class Cat
end

b = Bottle.new("Tab", 16)
c = Can.new("Coke", 12)

puts "result of b2 = b.add(c) - error!"
# b2 = b.add(c)

puts "result of b2 = b.add2(c)"
b2 = b.add2(c)
puts "b2 is #{b2}"

puts "result of b2 = b.add3(c)"
b2 = b.add3(c)
puts "b2 is #{b2}"

cat = Cat.new
puts "result of b2 = b.add3(cat) - error!"
# b2 = b.add3(cat)
