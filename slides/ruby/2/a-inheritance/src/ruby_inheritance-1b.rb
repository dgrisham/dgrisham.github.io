=begin
    Demo: Simple inheritance
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
    
    def sendEmail() 
        puts "Emailing #{@email}"
    end
end

class Student < Person
    def to_s
        # technically `@name` is not inherited... but it 
        # came into being when `initialize` was called
        "Name: #{@name}"
        # the following line generates output, then displays object ID
        #puts "Name: #{@name}"
    end
end

p = Person.new("Devin")
p.setupEmail("dev@mines.edu")
s = Student.new("Gene")
p.sendEmail
s.sendEmail
