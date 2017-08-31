=begin
    Demo: Simple inheritance
    Corresponds to: RubyInheritance.pptx
    Instance variables are not inherited
=end

class Person 
    def initialize(name)
        @name = name
        puts "initializing"
    end
    
    def setupEmail(email)
        @email = email
    end
    
    def letsEmail() 
        puts "Emailing #{@email}"
    end
    

end

class Student < Person
    def to_s
        # technically @name is not inherited... but it 
        # came into being when initialize was called
        "Name: #{@name}"
        # the following line generates output, then displays object ID
        #puts "Name: #{@name}"
    end

    
end

p = Person.new("Peter")
p.setupEmail("peter@mines.edu")
s = Student.new("Cyndi")
p.letsEmail
s.letsEmail


