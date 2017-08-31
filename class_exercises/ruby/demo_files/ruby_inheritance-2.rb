=begin
    Demo: Overriding inherited methods
    Corresponds to: RubyInheritance.pptx
=end

class Person
    def initialize(name)
        @name = name
    end
    def greeting
        puts "Hi, my name is #{@name}"
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

end

me = Person.new("Cyndi")
me.greeting
you = Student.new("Suzie", "CS")
you.greeting
