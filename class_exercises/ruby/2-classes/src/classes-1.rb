=begin
    Demo: Basic class structure
=end

class Cat
# DON'T declare instance variables here!
    # ctor is named initalize
    def initialize(name, age)
        # instance variables begin with @
        @name, @age = name, age
    end

    # to_s is similar to toString
    def to_s
        "(#@name, #@age)"
    end

    # getters
    def name
        @name
    end

    def age
        @age
    end

    # setters
    def name=(value)
        @name=value
    end

    def age=(value)
        @age=value
    end
end

c = Cat.new("Fluffy", 2)
puts c
puts c.name

c.age = 5
puts c.age
puts c.to_s
