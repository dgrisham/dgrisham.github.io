=begin
    Demo: Simple inheritance
=end

class Person 
    def initialize(name)
        @name = name
        puts "initializing"
    end

end

class Student < Person
    def to_s
        # technically @name is not inherited... but it 
        # came into being when initialize was called
        puts "Name: #{@name}"
    end
    
end

s = Student.new("Cyndi")
puts s

