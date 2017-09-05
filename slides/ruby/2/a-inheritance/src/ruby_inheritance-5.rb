=begin
    Demo: Class variables
=end

class Person
    def initialize(name)
        @name = name
        @@thing2 = "water"
    end

    def show
        puts "Person: #{@@thing1}"
    end
end

class Student < Person
    def make_thing1
        @@thing1 = "oil"
    end

    def show
        puts "Student: #{@@thing1} and #{@@thing2}"
    end

    def change_thing1
        @@thing1 = "fire"
    end
end

a = Person.new("Amy")
b = Student.new("Bob")
# creates class variable `thing1`
b.make_thing1
b.show
# all students can access `thing1`
c = Student.new("Joe")
c.show
# parent cannot access `thing1`
# a.show # error
