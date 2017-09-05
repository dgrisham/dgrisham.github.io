=begin
    Demo: Chaining methods
=end

class Person
    def initialize(name)
        @name = name
    end

    def introduce
        puts "Hi, I'm #{@name}."
    end
end

class Student < Person
    def initialize(name, major)
        super(name)
        @major = major
    end

    def introduce
        # `super` automatically calls the corresponding parent method
        super
        puts "I am studying #{@major}."
    end
end

p = Person.new("Lauryn")
p.introduce
s = Student.new("Shawn", "Poetry")
s.introduce
