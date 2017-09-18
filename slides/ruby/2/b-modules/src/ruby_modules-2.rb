=begin
    Demo: Module as mixin
=end

module FlyingCreature 
   def fly 
      puts "Flying! with speed #@speed"
   end 
end 
class Bird 
    include FlyingCreature 
    def initialize
      @speed = 5
    end
#... 
end 
class Mammal
# ...
end
class Bat < Mammal 
    include FlyingCreature
    #... 
end 

tweety = Bird.new
tweety.fly
puts "tweety is a flying creature? #{tweety.is_a? FlyingCreature}"

bat = Bat.new
bat.fly
puts "bat is a flying creature? #{bat.is_a? FlyingCreature}"

batman = Mammal.new
# batman.fly # error
puts "batman is a flying creature? #{batman.is_a? FlyingCreature}"
