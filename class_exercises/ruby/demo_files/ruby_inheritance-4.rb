=begin
    Demo: Chaining methods
=end

class Person
    def initialize(name)
        @name = name
    end
    def greeting
        puts "Hi, my name is #{@name}"
    end
    def long_greeting
        puts "Hi, my name is #{@name}."
    end
end

class Student < Person
    def initialize(name, major)
        super(name)
        @major = major
    end
    def greeting
        puts "Hi, I'm a student and my name is #{@name}"
    end
    def long_greeting
        # super automatically calls the corresponding parent method
        super
        puts "I am studying #{@major}."
    end
end

me = Person.new("Cyndi")
me.long_greeting
you = Student.new("Suzie", "CS")
you.long_greeting
