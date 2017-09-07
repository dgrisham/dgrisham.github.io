=begin
    Demo: Singleton method added to an object
=end

class Person
  def initialize(name)
     @name=name
  end
end

shugo = Person.new("Shugo")
matz = Person.new("Matz")

def matz.design_ruby
puts "I am #{@name} and I designed Ruby!"
end

matz.design_ruby 
shugo.design_ruby
