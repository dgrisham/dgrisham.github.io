=begin
    Demo: Overriding inherited methods
=end

class Person
    def initialize(name)
        @name = name
    end

    def introduce
        puts "Hi, I'm #{@name}"
    end
end

class Student < Person
    def initialize(name)
        super(name)
    end

    def introduce
        puts "I'm a student and my name is #{@name}"
    end
end

p = Person.new("Joe")
p.introduce
s = Student.new("Jamie")
s.introduce
