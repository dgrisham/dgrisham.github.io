=begin
    Demo: Module as mixin
    Corresponds to: RubyInheritance.pptx
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

daffy = Bird.new
daffy.fly
dracula = Bat.new 
dracula.fly
puts "dracula is a flying creature: #{dracula.is_a? FlyingCreature}"
piglet = Mammal.new
puts "piglet is a flying creature: #{piglet.is_a? FlyingCreature}"
