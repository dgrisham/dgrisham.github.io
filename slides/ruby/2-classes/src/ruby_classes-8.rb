=begin
    Demo: Class methods and variables
=end

class Bottle
    attr_accessor :ounces
    attr_reader :label
    # constant
    MAX_OUNCES = 64
    # class variable
    @@numBottles = 0

    def initialize(label, ounces)
        @label = label
        # update the class bottle count when new object is created
        @@numBottles += 1
        if ounces > MAX_OUNCES
            @ounces = MAX_OUNCES
        else
            @ounces = ounces
        end
    end

    def Bottle.sum(bottles)
        total = 0
        bottles.each {|b| total += b.ounces }
        total
    end

    def to_s
        "(#@label, #@ounces)"
    end

    def self.report
        puts "Number of bottles created: #@@numBottles"
    end
end

bottles = Array.new
bottles[0] = Bottle.new("Tab", 16)
bottles[1] = Bottle.new("Tab", 16)
bottles[2] = Bottle.new("Coke", 16)
bottles[3] = Bottle.new("Tab", 20)

puts "Total ounces: #{Bottle.sum bottles}"
b = Bottle.new("Sprite", 72)
puts b

# The following generates an error
# b.report
Bottle.report
