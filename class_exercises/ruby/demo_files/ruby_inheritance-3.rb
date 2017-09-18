=begin
    Demo: Abstract classes
=end

class AbstractGreeter
    # greet calls two abstract methods (greeting and who)
    def greet
        puts "#{greeting} #{who}"
    end
    def say_hi
        puts "hi"
    end
end

# this concrete class provides method definitions
class WorldGreeter < AbstractGreeter
    def greeting; "Hello"; end
    def who; "World"; end
end

WorldGreeter.new.greet
# Cannot use abstract method - undefined method error
# AbstractGreeter.new.greet
# We _can_ create an object of an abstract type
AbstractGreeter.new.say_hi


