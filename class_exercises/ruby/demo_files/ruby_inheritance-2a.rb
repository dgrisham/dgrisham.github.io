=begin
    Demo: Method visibility
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
    private :letsEmail

end
p = Person.new("Peter")
p.setupEmail("p@x.edu")
p.letsEmail
